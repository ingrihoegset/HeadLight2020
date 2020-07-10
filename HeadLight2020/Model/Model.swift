//
//  Model.swift
//  HeadLight2020
//
//  Created by Ingrid on 06/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMotion

class Model: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    let captureSession = AVCaptureSession()
    let motion = CMMotionManager()
    var flickerResults = 0.0
    var matrixOfPixels = [[Int]]()
    var rowOfSimultaneousPixels = [Int]()
    
    override init() {
        super.init()
        getVideoOutput()
    }
    
    func getVideoOutput() {
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String: Int(kCVPixelFormatType_32BGRA)]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        
        
        let videoOutputQueue = DispatchQueue(label: "VideoQueue")
        videoOutput.setSampleBufferDelegate(self, queue: videoOutputQueue)
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            print("Could not add video data as output.")
        }
    }
    
    //This function is called automatically each time a new frame is recieved, i.e. 240 times per second
    //as long as the configuration was successfull. Most of the analysis and processing goes on here.
    func captureOutput(_ captureOutput: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        //counts the number of frames that have been captured
        //counter = counter + 1

        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
        
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)!
        let byteBuffer = baseAddress.assumingMemoryBound(to: UInt8.self)
        
        
        //Chosen pixel for analysis
        //We are pointing to the location of the pixel in the memory space, and not to the coordinate on the image.
        //We therefore locate the pixel by going through a long memory array, rather than a coordinate on a (x,y) format.
        //To find the pixel at (1,0) point on the image means we have to find the pixel at the (width + 1) space in the array.
        //We have to increase the index by 4 to get to a new pixel in the array.
        //This is because every pixel is represented by 4 bits of memory, so to get to the next pixel, we must move
        //4 spaces down the array.
        
        //Dont know what this does, but dont move
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))

        createPixelMatrix(byteBuffer: byteBuffer, width: width, height: height)
    
    }
    
    //Calculates gray scale of pixel
    func getPixelNumber(byteBuffer: UnsafeMutablePointer<UInt8>, index: Int) -> Int {
        let b = byteBuffer[index]
        let bInt = Double(b)
        let g = byteBuffer[index + 1]
        let gInt = Double(g)
        let r = byteBuffer[index + 2]
        let rInt = Double(r)
        
        //Find the shade of gray represented by the rgb
        let gray = (bInt + gInt + rInt) / 3
        
        return Int(gray)
    }
    
    func startAnalysis() {
        isPhoneStill()
    }
    
    //Should send alert to flicker analysis process when phone has been held still for long enough
    func isPhoneStill() {
        var isStillArray = [Bool]()
        motion.deviceMotionUpdateInterval = 0.25
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in

            if let trueData = data {
                let mRotationRate = trueData.rotationRate
                //When analysis array is not loaded with data yet
                if isStillArray.count < 8 {
                    if (abs(mRotationRate.x)) > 0.05 || abs(mRotationRate.y) > 0.05 || abs(mRotationRate.z) > 0.05 {
                        isStillArray.append(false)
                    }
                    else {
                        isStillArray.append(true)
                    }
                }
                
                //When analysis array is full and needs to be gradually filled with new data
                if isStillArray.count >= 8 {
                    if (abs(mRotationRate.x)) > 0.05 || abs(mRotationRate.y) > 0.05 || abs(mRotationRate.z) > 0.05 {
                        isStillArray.removeFirst()
                        isStillArray.append(false)
                    }
                    else {
                        isStillArray.removeFirst()
                        isStillArray.append(true)
                    }
                    
                    if isStillArray.allSatisfy({$0}){
                        self.motion.stopDeviceMotionUpdates()
                        print("Phone is being held still")
                    }
                }
            }
        }
    }
    
    
    func interruptAnalysis() {
        motion.stopDeviceMotionUpdates()
    }
    
    /*Makes an matrix containing the pixeldata from a subset of pixels
      The function is called as long as capture_output is called, i.e. 240 times
      per second. The data in the matrix is the basis for the flickeranalysis*/
    func createPixelMatrix(byteBuffer: UnsafeMutablePointer<UInt8>, width: Int, height: Int) {
        
        //first is row
        //second is column
        
        //Empty row so it is ready for new input
        rowOfSimultaneousPixels = []
        
        //Removes the oldest input from the matrix when the matrix reaches a certain size
        if(matrixOfPixels.count >= 240) {
            matrixOfPixels.removeFirst(1)
        }
        
        //Returns array of 36 simultaneous pixels with leap of * 20
        for i in stride(from: 0, to: width * height * 4 - 1, by: width * 4 * 2 ) {
            let pixel = getPixelNumber(byteBuffer: byteBuffer, index: i)
            rowOfSimultaneousPixels.append(pixel)
        }
        
        //Adds the array of simultaneus pixels to the matrix
        matrixOfPixels.append(rowOfSimultaneousPixels)
    }
    
    /*Does analysis of each pixel over the amount of frames captued and returns an matrix with arrays
     of info related to each pixel. The info captured for each pixel is average top of the wave
     (average of highest point above average every time the wave crosses the average line from below),
     average bottom of the wave (average of lowest point below average every time the wave crosses the
     average from above, the average pixel colour of grey and the number of waves (number of times
     the wave crosses the average line from either above or below)*/
    func calculateFlickerInfo() -> [[Int]]{
        
        //captures the resulting info that follows from the analysis of a given pixel
        var arrayOfPixelWaveInfo = [Int]()
        //captures all the arrays of pixel analysis
        var matrixOfTotalWaveInfo = [[Int]]()

        //this is the actual matrix of pixels that is analyzed. It is based on the current matrix
        //when a given event happens.
        let matrixOfPixelsForAnalysis = matrixOfPixels
        //an array with the average pixel colour for each pixel being analyzed
        let arrayOfAverageFlicker = calculateAverageFlicker(matrix: matrixOfPixelsForAnalysis)
        
        var currentTop = arrayOfAverageFlicker[0]
        var sumTops = 0
        var countTops = 0
        
        var currentBottom = arrayOfAverageFlicker[0]
        var sumBottoms = 0
        var countBottoms = 0
        
        if (matrixOfPixels.count > 120) {
        
            //each column contains the pixel colors related to one specific pixel
            for column in 0...matrixOfPixelsForAnalysis[0].count - 1 {
                //reset helper values
                sumBottoms = 0
                sumTops = 0
                countTops = 0
                countBottoms = 0
                
                //fetch appropriate average for pixel that is being analyzed
                let average = arrayOfAverageFlicker[column]
                
                //each row contains an observation of the given pixels color in the given frame
                for row in 1...matrixOfPixelsForAnalysis.count - 1 {
                    //determines if the wave is below average. If so, we are looking for
                    //the lowest color (bottom point) we can find before the next infliction.
                    if (isInflictionFromAbove(average: average, previous: matrixOfPixelsForAnalysis[row - 1][column], current: matrixOfPixelsForAnalysis[row][column])) {
                        sumTops = sumTops + currentTop
                        countTops = countTops + 1
                        currentBottom = matrixOfPixelsForAnalysis[row][column]
                    }
                    //determines if the wave is above average. If so, we are looking for the highest
                    //color (top point) we can find before the next infliction.
                    if (isInflictionFromBelow(average: average, previous: matrixOfPixelsForAnalysis[row - 1][column], current: matrixOfPixelsForAnalysis[row][column])) {
                        sumBottoms = sumBottoms + currentBottom
                        countBottoms = countBottoms + 1
                        currentTop = matrixOfPixelsForAnalysis[row][column]
                    }
                    //finds and maintains the lowest point after an infliction
                    if (matrixOfPixelsForAnalysis[row][column] < currentBottom) {
                        currentBottom = matrixOfPixelsForAnalysis[row][column]
                    }
                    //finds and maintains the highest point after an infliction
                    if (matrixOfPixelsForAnalysis[row][column] > currentTop) {
                        currentTop = matrixOfPixelsForAnalysis[row][column]
                    }
                }
                //makes sure that we avoid the error that would follow from dividing by 0 if count is zero
                //is also useful for further analysis because we can leave out these pixels.
                if (countBottoms == 0 || countTops == 0) {
                    arrayOfPixelWaveInfo = [1000,1,1,1]
                }
                //prepares and stores the desired info in the array of pixel info
                else {
                    let averageWaveTop = sumTops / countTops
                    let averageWaveBottom = sumBottoms / countBottoms
                    let noOfWaves = countTops
                    arrayOfPixelWaveInfo = [average, averageWaveTop, averageWaveBottom, noOfWaves]
                }
                //append every array of pixel info to the matrix of total info
                matrixOfTotalWaveInfo.append(arrayOfPixelWaveInfo)
            }
        }
        return matrixOfTotalWaveInfo
    }
    
    //yields an array of average pixel color. average relates to analysis of one given pixel.
    func calculateAverageFlicker(matrix: [[Int]]) -> [Int] {
        var sum = 0
        var average = 0
        var arrayOfAverageFlicker = [Int]()
        
        for column in 0...matrix[0].count - 1 {
            sum = 0
            for row in 0...matrix.count - 1 {
                sum = sum + matrix[row][column]
            }
            average = sum / matrix.count
            arrayOfAverageFlicker.append(average)
        }
        print("averages ", arrayOfAverageFlicker)
        
        return arrayOfAverageFlicker
    }
    
    //checks if the wave is crossing the average from below. If so, we are entering the top half of the wave.
    func isInflictionFromBelow(average: Int, previous: Int, current: Int) -> Bool {
        //infliction crosses average from below
        if (current > average && previous < average) {
            return true
        }
        //not infliction crossing average line
        else {
            return false
        }
    }
    
    //checks if the wave is crossing the average from above. If so, we are entering the bottom half of the wave.
    func isInflictionFromAbove(average: Int, previous: Int, current: Int) -> Bool {
        //infliction crosses average from above
        if (current < average && previous > average) {
            return true
        }
        //not infliction crossing average line
        else {
            return false
        }
    }
    
    //Consider removing outliers
    func calculateFlickerPercent() {
        
        let matrixToBeAnalyzed = calculateFlickerInfo()
        var lMax = 0.0
        var lMin = 0.0
        var flickerPercentPixel = 0.0
        var arrayOfFlickerPercentages = [Double]()

        for pixel in 0...matrixToBeAnalyzed.count - 1 {
            if (matrixToBeAnalyzed[pixel][0] != 1000) {
                lMax = Double(matrixToBeAnalyzed[pixel][1])
                lMin = Double(matrixToBeAnalyzed[pixel][2])
                flickerPercentPixel = (lMax - lMin) / (lMax + lMin)
                arrayOfFlickerPercentages.append(flickerPercentPixel)
            }
        }
        
        var sumFlickerPercent = 0.0
        for percent in 0...arrayOfFlickerPercentages.count - 1 {
            sumFlickerPercent = sumFlickerPercent + arrayOfFlickerPercentages[percent]
        }
        
        let averageFlickerPercent = sumFlickerPercent / Double(arrayOfFlickerPercentages.count)
        flickerResults = averageFlickerPercent
        
        print(averageFlickerPercent)
        
        //Obs, what is being posted is always the previous measurement, not the current. WHY?!
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
    }
    
    
    func calculateFlickerIndex() {
        
    }
}
