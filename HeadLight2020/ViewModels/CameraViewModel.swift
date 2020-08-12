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

    //let model: Model
    let fourierModel: FourierModel
    let captureSession: AVCaptureSession
    let motionSensor: MotionSensor
    var flickerPercent: Double
    var flickerIndex: Double
    var hertz: Double
    var state: State
    
    /*init(model: Model) {
        
        self.model = model
        self.captureSession = model.cameraCapture.captureSession
        self.flickerPercent = model.flickerPercent
        self.flickerIndex = model.flickerIndex
        self.hertz = model.hertz
        self.motionSensor = MotionSensor()
        self.state = model.state
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewResults), name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(calculateResults), name: NSNotification.Name.init(rawValue: "calculateResults"), object: nil)
    }*/
    
    init(fourierModel: FourierModel) {
        
        self.fourierModel = fourierModel
        self.captureSession = fourierModel.cameraCapture.captureSession
        self.flickerPercent = fourierModel.flickerPercent
        self.flickerIndex = fourierModel.flickerIndex
        self.hertz = fourierModel.hertz
        self.motionSensor = MotionSensor()
        self.state = fourierModel.state
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewResults), name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(calculateResults), name: NSNotification.Name.init(rawValue: "calculateResults"), object: nil)
    }
    
    @objc func getNewResults() {
        self.flickerPercent = fourierModel.flickerPercent * 100
        self.flickerIndex = fourierModel.flickerIndex * 100
        self.hertz = fourierModel.hertz
        self.state = fourierModel.state
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "segueToResults"), object: nil)
    }
    
    @objc func calculateResults() {
        fourierModel.calculateResults()
    }
    
    func startMotionSensor() {
        motionSensor.isPhoneStill()
    }
    
    func interruptMotionSensor() {
        motionSensor.interruptMotionSensor()
    }
}
    

    
    
