//
//  FourierModel.swift
//  HeadLight2020
//
//  Created by Ingrid on 10/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import Accelerate
import Charts

class FourierModel: NSObject {
    
    var pixels = [[Float]]()
    let forwardDCTSetup = vDSP.DCT(count: 240, transformType: vDSP.DCTTransformType.II)
    var flickerIndex = 0.0
    var flickerPercent = 0.0
    var hertz = 0.0
    var luminance = 0.0
    let cameraCapture: CameraCapture
    let stateholder = StateHolder()
    var state: State
    
    init(cameraCapture: CameraCapture) {
        self.cameraCapture = cameraCapture
        self.state = stateholder.OK
    }
    
    func calculateResults() {
    
        pixels = cameraCapture.getMatrixFourier()
            
        let signals = transposeMatrix(matrix: pixels)
        var resultArray = [Result]()
        
        for i in 0...signals.count - 1 {
            var forwardDCT = forwardDCTSetup!.transform(signals[i])
            
            vDSP.threshold(forwardDCT,
            to: 50,
            with: .zeroFill,
            result: &forwardDCT)
            
            var counter = 0.0
            var max = Float(0)
            var index = Double(0)
            var value = Float(0)
            for i in 0...forwardDCT.count - 1 {
                if (i == 0) {
                    max = 0
                    index = 0
                    value = forwardDCT[i]
                }
                else {
                    if (forwardDCT[i] > max) {
                        max = forwardDCT[i]
                        index = counter
                        value = forwardDCT[i]
                    }
                }
                counter = counter + 1
            }
            
            //Deler på ANTALL OBSERVASJONER i datasettet for å finne snittet
            let thisHertz = Int(index/2)
            let lumosity = forwardDCT[0] / Float(Constants.noOfFramesForAnalysis)
            
            let result = Result(lumosity: lumosity, hertz: thisHertz, value: value)
            resultArray.append(result)
            
        }
        
        let modeHertz = findModeOfArray(array: resultArray)
        let averageAmplitude = findAverageAmplitude(array: resultArray, mode: modeHertz)
        let averageLumosity = findAverageLumosity(array: resultArray, mode: modeHertz)
        luminance = Double(averageLumosity)

        let preflickerPercent = calculateFlickerPercent(averageLumosity: averageLumosity, averageAmplitude: averageAmplitude)
        flickerPercent = preflickerPercent
        
        flickerIndex = calculateFlickerIndex(averageLumosity: averageLumosity, modeHertz: modeHertz, averageAmplitude: averageAmplitude)
        
        let calculatedState = calculateZone(hertz: modeHertz, flickerPercent: flickerPercent)
        state = calculatedState
        
        let preHertz = Double(modeHertz)
        hertz = roundHertz(hertz: preHertz)
        
        //Notifies viewModel to update its relevant parameters
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
    }

    
    //transposes matrix so that each row corresponds to data from 1 pixel (before transposing, data from the same pixel is stored in a column)
    func transposeMatrix(matrix: [[Float]]) -> [[Float]]{
        var transposedArray = [[Float]]()
        var helperRow = [Float]()
        let noOfRows = matrix.count
        let noOfColumns = matrix[0].count
        
        for column in 0...noOfColumns - 1 {
            helperRow = []
            for row in 0...noOfRows - 1 {
                let data = matrix[row][column]
                helperRow.append(data)
                
            }
            transposedArray.append(helperRow)
        }
        return transposedArray
    }
    
    //Returns the frequency with the highest number of occurances is the dataset
    func findModeOfArray(array: [Result]) -> Int {
        
        var hertzCountDictionary = [Int: Int]()
        
        //Counts the occurance of each frequency
        for element in array {
            if let count = hertzCountDictionary[element.hertz] {
                hertzCountDictionary[element.hertz] = count + 1
            }
            else {
                hertzCountDictionary[element.hertz] = 1
            }
        }
        
        /*for key in hertzCountDictionary.keys {
            print("\(key): \(hertzCountDictionary[key]!)")
        }*/
        
        //Sorts the dictionary and returns the number of occurances for frequency with the highest number of occurances
        let sortedCount = hertzCountDictionary.values.sorted(by: >)
        //Occurances
        let mode = sortedCount[0]
        
        var hertzWithHighestMode = 0
        //Find the frequency corresponding to the highest number of occurances (i.e.the mode)
        for key in hertzCountDictionary.keys {
            if (hertzCountDictionary[key] == mode) {
                hertzWithHighestMode = key
            }
        }
        return hertzWithHighestMode
    }
    
    func findAverageAmplitude(array: [Result], mode: Int) -> Float {
        
        var sum = Float(0)
        var count = Float(0)
        for element in array {
            if element.hertz == mode {
                sum = sum + element.value
                count = count + 1
            }
        }
        let averageAmplitude = (sum  / 240) / count
        return averageAmplitude
    }
    
    func findAverageAmplitudeForAll() -> [ChartDataEntry] {
        
        let pixelsForAmplitude = cameraCapture.getMatrixForVisuals()
            
        let signals = transposeMatrix(matrix: pixelsForAmplitude)
        var resultArray = [Result]()
        
        for i in 0...signals.count - 1 {
            var forwardDCT = forwardDCTSetup!.transform(signals[i])
            
            vDSP.threshold(forwardDCT,
            to: 100,
            with: .zeroFill,
            result: &forwardDCT)
            
            for i in 0...forwardDCT.count - 1 {
                let thisHertz = Int(i/2)
                let result = Result(hertz: thisHertz, value: forwardDCT[i])
                resultArray.append(result)
            }
            
            //Deler på ANTALL OBSERVASJONER i datasettet for å finne snittet

        }
        
        var amplitudeArray = [ChartDataEntry]()
        
        for i in -6...5 {
            var sum = Float(0)
            var count = Float(0)
            
            if i % 3 == 0 {
                for element in resultArray {
                    if element.hertz == i {
                        sum = sum + element.value
                        count = count + 1
                    }
                }
                var averageAmplitude = (sum / 240 / 240) / count
                if (averageAmplitude.isNaN){
                    averageAmplitude = 0
                }
                amplitudeArray.append(ChartDataEntry(x: Double(i), y: Double(averageAmplitude)))
            }
        }
        
        for i in 6...130 {
            
            var sum = Float(0)
            var count = Float(0)
            
            if i % 3 == 0 {
                for element in resultArray {
                    if element.hertz == i {
                        sum = sum + element.value
                        count = count + 1
                    }
                }
                var averageAmplitude = (sum / 240) / count
                if (averageAmplitude.isNaN){
                    averageAmplitude = 0
                }
                amplitudeArray.append(ChartDataEntry(x: Double(i), y: Double(averageAmplitude)))
            }
        }
        return amplitudeArray
    }
    
    func findAverageLumosity(array: [Result], mode: Int) -> Float {
        var sum = Float(0)
        var count = Float(0)
        for element in array {
            if (element.hertz == mode) {
                sum = sum + element.lumosity
                count = count + 1
            }
        }
        let averageLumosity = sum / count
        luminance = Double(averageLumosity)
        return averageLumosity
    }
    
    func calculateFlickerPercent(averageLumosity: Float, averageAmplitude: Float) -> Double {
        let LLow = averageLumosity - averageAmplitude
        let LHigh = averageLumosity + averageAmplitude
        let flickerPercent = ((LHigh - LLow) / averageLumosity)
        return Double(flickerPercent)
    }
    
    func calculateFlickerIndex(averageLumosity: Float, modeHertz: Int, averageAmplitude: Float) -> Double {
        let pi = Float.pi
        let hertz = Float(modeHertz)
        let periode = (2 * pi) / hertz
        let topStart = Float(0)
        let topEnd = periode / 2
        
        //Integral is - (A/b * cos(bt)) + dt + C
        let fullArea = (-(averageAmplitude / hertz) * (cos(hertz * periode)) + averageLumosity * periode) - (-(averageAmplitude / hertz) * (cos(hertz * topStart)) + averageLumosity * topStart)
        
        //area under peak
        let peakArea = -(averageAmplitude / hertz) * (cos(hertz * topEnd) - cos(hertz * topStart))
        let bottomArea = fullArea - peakArea
        
        let flickerIndex = peakArea / bottomArea
        return Double(flickerIndex)
    }
    
    func calculateState(hertz: Int, flickerPercent: Double) -> State {
        
        var calculatedState = stateholder.OK
        
        if (flickerPercent < 0.01) {
            calculatedState = stateholder.best
        }
        else if (flickerPercent < 0.05) {
            calculatedState = stateholder.secondBest
        }
        else if (flickerPercent < 0.10) {
            calculatedState = stateholder.OK
        }
        else if (flickerPercent < 0.20) {
            calculatedState = stateholder.secondWorst
        }
        else if (flickerPercent >= 0.20) {
            calculatedState = stateholder.worst
        }
        
        // To account for when the light is without flicker (flicker must be set to 0 manually because of the strange things that happen when hertz is close to 0)
        if (hertz < 10) {
            calculatedState = stateholder.best
            self.flickerPercent = 0
            self.flickerIndex = 0
        }
        
        return calculatedState
    }
    
    func calculateZone(hertz: Int, flickerPercent: Double) -> State {
        
        var calculatedState = stateholder.best
        let thisHertz = Double(hertz)
        let thisFlickerPercent = flickerPercent * 100
        
        
        // To account for when the light is without flicker (flicker must be set to 0 manually because of the strange things that happen when hertz is close to 0)
        if (thisHertz < 10) {
            calculatedState = stateholder.best
            self.flickerPercent = 0
            self.flickerIndex = 0
            return calculatedState
        }
        
        //check if catostrophic
        if (thisFlickerPercent > 0.05 && thisHertz < 65) {
            calculatedState = stateholder.worst
            return calculatedState
        }
            
        //When hertz is below 90
        if (thisHertz < 90) {
            //check if high risk
            if (thisFlickerPercent >= 0.025 * thisHertz) {
                calculatedState = stateholder.secondWorst
                return calculatedState
            }
            
            //check if in low risk zone
            else if (thisFlickerPercent >= 0.01 * thisHertz) {
                calculatedState = stateholder.OK
                return calculatedState
            }
            
            //check if in good zone
            else if (thisFlickerPercent < 0.01 * thisHertz) {
                calculatedState = stateholder.secondBest
                return calculatedState
            }
        }
        //When hertz is above 905
        else if (thisHertz >= 90) {
            //check if high risk
            if (thisFlickerPercent >= 0.08 * thisHertz) {
                calculatedState = stateholder.secondWorst
                return calculatedState
            }
            
            //check if in low risk zone
            else if (thisFlickerPercent >= 0.033 * thisHertz) {
                calculatedState = stateholder.OK
                return calculatedState
            }
            
            //check if in good zone
            else if (thisFlickerPercent < 0.033 * thisHertz) {
                calculatedState = stateholder.secondBest
                return calculatedState
            }
        }
        return calculatedState
    }
    
    
    func roundHertz(hertz: Double) -> Double {
        var hertz = hertz
        if (hertz < 5) {
            hertz = 0
        }
        else if (hertz < 15) {
            hertz = 10
        }
        else if (hertz < 25) {
            hertz = 20
        }
        else if (hertz < 35) {
            hertz = 30
        }
        else if (hertz < 45) {
            hertz = 40
        }
        else if (hertz < 55) {
            hertz = 50
        }
        else if (hertz < 65) {
            hertz = 60
        }
        else if (hertz < 75) {
            hertz = 70
        }
        else if (hertz < 85) {
            hertz = 80
        }
        else if (hertz < 95) {
            hertz = 90
        }
        else if (hertz < 105) {
            hertz = 100
        }
        else if (hertz < 115) {
            hertz = 110
        }
        else if (hertz < 125) {
            hertz = 120
        }
        else if (hertz < 135) {
            hertz = 130
        }
        else if (hertz < 145) {
            hertz = 140
        }
        else if (hertz < 155) {
            hertz = 150
        }
        return hertz
    }
    
    func roundFlickerPercent(flickerPercent: Double) -> Double {
        var flickerPercent = flickerPercent
        if (flickerPercent < 0.01) {
            flickerPercent = 0
        }
        else if (flickerPercent < 0.05) {
            flickerPercent = 0.03
        }
        else if (flickerPercent < 0.10) {
            flickerPercent = 0.05
        }
        else if (flickerPercent < 0.15) {
            flickerPercent = 0.10
        }
        else if (flickerPercent < 0.20) {
            flickerPercent = 0.15
        }
        else if (flickerPercent < 0.30) {
            flickerPercent = 0.25
        }
        else if (flickerPercent < 0.40) {
            flickerPercent = 0.35
        }
        else if (flickerPercent < 0.50) {
            flickerPercent = 0.45
        }
        else if (flickerPercent < 0.60) {
            flickerPercent = 0.55
        }
        else if (flickerPercent < 0.70) {
            flickerPercent = 0.65
        }
        else if (flickerPercent < 0.80) {
            flickerPercent = 0.75
        }
        else if (flickerPercent < 0.90) {
            flickerPercent = 0.85
        }
        else if (flickerPercent < 1.05) {
            flickerPercent = 0.95
        }
        return flickerPercent
    }
}
