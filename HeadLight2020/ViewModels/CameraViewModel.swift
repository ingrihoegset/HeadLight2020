//
//  CameraViewModel.swift
//  HeadLight2020
//
//  Created by Ingrid on 06/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import AVFoundation


class CameraViewModel {

    let model: Model
    let captureSession: AVCaptureSession
    let motionSensor: MotionSensor
    var flickerPercent: Double
    var flickerIndex: Double
    var hertz: Double
    var state: State
    
    init(model: Model) {
        
        self.model = model
        self.captureSession = model.cameraCapture.captureSession
        self.flickerPercent = model.flickerPercent
        self.flickerIndex = model.flickerIndex
        self.hertz = model.hertz
        self.motionSensor = MotionSensor()
        self.state = model.state
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewResults), name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(calculateResults), name: NSNotification.Name.init(rawValue: "calculateResults"), object: nil)
    }
    
    @objc func getNewResults() {
        self.flickerPercent = model.flickerPercent * 100
        self.flickerIndex = model.flickerIndex * 100
        self.hertz = model.hertz
        self.state = model.state
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "segueToResults"), object: nil)
    }
    
    @objc func calculateResults() {
        model.setMatrixForAnalysis()
        model.calculateFlickerPercent()
        model.calculateFlickerIndex()
        model.calculateState()
        print(state)
    }
    
    func startMotionSensor() {
        motionSensor.isPhoneStill()
    }
    
    func interruptMotionSensor() {
        motionSensor.interruptMotionSensor()
    }
}
    

    
    
