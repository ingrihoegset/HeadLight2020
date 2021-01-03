//
//  CameraViewModel.swift
//  HeadLight2020
//
//  Created by Ingrid on 06/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import AVFoundation
import Charts


class CameraViewModel {

    //let model: Model
    let fourierModel: FourierModel
    let captureSession: AVCaptureSession
    let motionSensor: MotionSensor
    var flickerPercent: Double
    var flickerIndex: Double
    var hertz: Double
    var luminance: Double
    var lightDetected: Bool
    var state: State
    var phoneIsStill: Bool
    var allAmplitudes: [ChartDataEntry]
    
    init(fourierModel: FourierModel) {
        

        
        self.fourierModel = fourierModel
        self.captureSession = fourierModel.cameraCapture.captureSession
        self.flickerPercent = fourierModel.flickerPercent
        self.flickerIndex = fourierModel.flickerIndex
        self.hertz = fourierModel.hertz
        self.luminance = fourierModel.luminance
        self.motionSensor = MotionSensor()
        self.state = fourierModel.state
        self.lightDetected = true
        self.phoneIsStill = false
        self.allAmplitudes = []
        
        
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewResults), name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(calculateResults), name: NSNotification.Name.init(rawValue: "calculateResults"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(phoneIsNotStillAlert), name: NSNotification.Name.init(rawValue: "phoneIsNotStill"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getWaveData), name: NSNotification.Name.init(rawValue: "getWaveData"), object: nil)
    }
    
    @objc func getNewResults() {
        self.flickerPercent = fourierModel.flickerPercent * 100
        self.flickerIndex = fourierModel.flickerIndex * 100
        self.hertz = fourierModel.hertz
        self.luminance = fourierModel.luminance
        self.lightDetected = checkForLight()
        self.state = fourierModel.state
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "segueToResults"), object: nil)
    }
    
    @objc func calculateResults() {
        fourierModel.calculateResults()
    }
    
    @objc func phoneIsNotStillAlert() {
        phoneIsStill = false
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "holdPhoneStillToast"), object: nil)
    }
    
    func startMotionSensor() {
        motionSensor.isPhoneStill()
    }
    
    func interruptMotionSensor() {
        motionSensor.interruptMotionSensor()
    }
    
    func checkForLight() -> Bool {
        if (luminance < 40 && hertz < 20) {
            return false
        }
        else {
            return true
        }
    }
    
    @objc func getWaveData() {
        self.allAmplitudes = fourierModel.findAverageAmplitudeForAll()
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "waveDataReady"), object: nil)
    }
}
    

    
    
