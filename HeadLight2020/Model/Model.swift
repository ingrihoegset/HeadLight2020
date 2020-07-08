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
    var flickerResults = 0
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
        
        //print(getPixelNumber(byteBuffer: byteBuffer, index: 0))
        
        
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
        
        flickerResults = Int(getPixelNumber(byteBuffer: byteBuffer, index: 0))

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
        for i in stride(from: 0, to: width * height * 4 - 1, by: width * 4 * 120 ) {
            let pixel = getPixelNumber(byteBuffer: byteBuffer, index: i)
            rowOfSimultaneousPixels.append(pixel)
        }
        
        //Adds the array of simultaneus pixels to the matrix
        matrixOfPixels.append(rowOfSimultaneousPixels)
    }
    
    func calculateFlickerIndex() {
        
    }
    
    func calculateFlickerPercent() {

        let average = calculateAverageFlicker()
        
        var currentTop = average
        var sumTops = 0
        var countTops = 1
        
        var currentBottom = average
        var sumBottoms = 0
        var countBottoms = 1
        
        if (matrixOfPixels.count > 120) {
        
            for i in 1...matrixOfPixels.count - 1 {
                if (isInflictionFromAbove(average: average, previous: matrixOfPixels[i - 1][0], current: matrixOfPixels[i][0])) {
                    sumTops = sumTops + currentTop
                    countTops = countTops + 1
                }
                
                if (isInflictionFromBelow(average: average, previous: matrixOfPixels[i - 1][0], current: matrixOfPixels[i][0])) {
                    sumBottoms = sumBottoms + currentBottom
                    countBottoms = countBottoms + 1
                }

                if (matrixOfPixels[i][0] < currentBottom) {
                    currentBottom = matrixOfPixels[i][0]
                }
                
                if (matrixOfPixels[i][0] > currentTop) {
                    currentTop = matrixOfPixels[i][0]
                }
            }
            
            print("avg top",  sumTops / countTops)
            print("count top", countTops)
            print("avg bot",  sumBottoms / countBottoms)
            print("count bot", countBottoms)
            
            let lMin = Double(sumBottoms / countBottoms)
            let lMax = Double(sumTops / countTops)
            let percentageFlicker = ((lMax - lMin) / (lMax + lMin)) * 100
            print("percentage flicker: ", percentageFlicker)
            
        }
    }
    
    func calculateAverageFlicker() -> Int {
        var sum = 0
        
        for i in 0...matrixOfPixels.count - 1 {
            sum = sum + matrixOfPixels[i][0]
        }
        
        let average = sum / matrixOfPixels.count
        return average
    }
    
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
}
