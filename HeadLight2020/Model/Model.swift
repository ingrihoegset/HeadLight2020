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

class Model: NSObject {
    
    var rowOfSimultaneousPixels = [Int]()
    let pi = Double.pi
    var flickerIndex = 0.0
    var flickerPercent = 0.0
    var hertz = 0.0
    var luminance = 0.0
    var matrixOfPixelsForAnalysis = [[Int]]()
    let cameraCapture: CameraCapture
    var matrixOfTotalWaveInfo = [[Int]]()
    
    init(cameraCapture: CameraCapture) {
        self.cameraCapture = cameraCapture
    }
    
    func setMatrixForAnalysis() {
        matrixOfPixelsForAnalysis = cameraCapture.getMatrix()
        matrixOfTotalWaveInfo = calculateFlickerInfo()
    }
    
    /*Does analysis of each pixel over the amount of frames captued and returns an matrix with arrays
     of info related to each pixel. The info captured for each pixel is average top of the wave
     (average of highest point above average every time the wave crosses the average line from below),
     average bottom of the wave (average of lowest point below average every time the wave crosses the
     average from above, the average pixel colour of grey and the number of waves (number of times
     the wave crosses the average line from either above or below)*/
    func calculateFlickerInfo() -> [[Int]] {
        
        //captures the resulting info that follows from the analysis of a given pixel
        var arrayOfPixelWaveInfo = [Int]()
        //captures all the arrays of pixel analysis
        var matrixOfTotalWaveInfo = [[Int]]()
        //an array with the average pixel colour for each pixel being analyzed
        let arrayOfAverageFlicker = calculateAverageFlicker(matrix: matrixOfPixelsForAnalysis)
        
        var currentTop = arrayOfAverageFlicker[0]
        var sumTops = 0
        var countTops = 0
        
        var currentBottom = arrayOfAverageFlicker[0]
        var sumBottoms = 0
        var countBottoms = 0
        
        if (matrixOfPixelsForAnalysis.count > 60) {
        
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
                print(matrixOfTotalWaveInfo)
        
        var lMax = 0.0
        var lMin = 0.0
        var flickerPercentPixel = 0.0
        var arrayOfFlickerPercentages = [Double]()

        for pixel in 0...matrixOfTotalWaveInfo.count - 1 {
            //Only analyze valid pixels. Pixels marked as 1000 are invalid
            if (matrixOfTotalWaveInfo[pixel][0] != 1000) {
                lMax = Double(matrixOfTotalWaveInfo[pixel][1])
                lMin = Double(matrixOfTotalWaveInfo[pixel][2])
                flickerPercentPixel = (lMax - lMin) / (lMax + lMin)
                arrayOfFlickerPercentages.append(flickerPercentPixel)
            }
        }
        
        var sumFlickerPercent = 0.0
        for percent in 0...arrayOfFlickerPercentages.count - 1 {
            sumFlickerPercent = sumFlickerPercent + arrayOfFlickerPercentages[percent]
        }
        
        let averageFlickerPercent = sumFlickerPercent / Double(arrayOfFlickerPercentages.count)
        flickerPercent = averageFlickerPercent
    }
    
    //Jeg er ikke 100 % overbevist om at "b" er regnet ut riktig, g også om endpoint og peakend er riktig.
    func calculateFlickerIndex() {
        print(matrixOfTotalWaveInfo)
        
        //Obs, should only be called once and than do all calcs based on the result
        var sumWaveTop = 0.0
        var sumWaveBottom = 0.0
        var sumWaveCount = 0.0
        var noOfValidPixels = 0.0
        
        //define amplitude for curve
        for pixel in 0...matrixOfTotalWaveInfo.count - 1 {
            //Only analyze valid pixels. Pixels marked as 1000 are invalid
            if (matrixOfTotalWaveInfo[pixel][0] != 1000) {
                sumWaveTop = sumWaveTop + Double(matrixOfTotalWaveInfo[pixel][1])
                sumWaveBottom = sumWaveBottom + Double(matrixOfTotalWaveInfo[pixel][2])
                sumWaveCount = sumWaveCount + Double(matrixOfTotalWaveInfo[pixel][3])
                noOfValidPixels = noOfValidPixels + 1
            }
        }
        
        //y = A * sin(b * t) + vs
        let averageWaveTop = sumWaveTop / noOfValidPixels
        let averageWaveBottom = sumWaveBottom / noOfValidPixels
        let averageWaveCount = sumWaveCount / noOfValidPixels
        let amplitude = (averageWaveTop - averageWaveBottom) / 2
        let verticalShift = averageWaveTop - amplitude
        let b = averageWaveCount * (Double(Constants.noOfFramesPerSecond) / Double(Constants.noOfFramesForAnalysis))
        hertz = Double(b)
        luminance = verticalShift
        
        //Integral from 0 to endpoint to find area under graf
        let endpoint = (2 * pi) / b
        //Intgegral from 0 halfway to endpoint with vs of 0 to find area under peak that is above avg. light emittance
        let peakEnd = endpoint / 2
        
        //Integral is - (A/b * cos(bt)) + dt + C
        //Area under one full wave is from 0 to endpoint (depends on how many waves per second)
        let fullArea = (-(amplitude / b) * cos(b * endpoint) + verticalShift * endpoint) - (-(amplitude / b) * cos(b * 0) + verticalShift * 0)
        
        //Peakarea is area under one half wave, and is from 0 to half of endpoint (depends on how many waves per second)
        let peakArea = (-(amplitude / b) * cos(b * peakEnd)) - (-(amplitude / b) * cos(b * 0))

        //finally we can calculate the flickerIndex
        flickerIndex = peakArea / (fullArea - peakArea)
        
        //Notifies viewModel to update its relevant parameters
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
    }
}
