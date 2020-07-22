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
    var flickerPercent: Double
    var flickerIndex: Double
    var hertz: Double
    
    init(model: Model) {
        
        self.model = model
        self.captureSession = model.cameraCapture.captureSession
        self.flickerPercent = model.flickerPercent
        self.flickerIndex = model.flickerIndex
        self.hertz = model.hertz
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewResults), name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
    }
    
    func startAnalysis() {
        model.cameraCapture.startAnalysis()
    }
    
    func interruptAnalysis() {
        model.cameraCapture.interruptAnalysis()
    }
    
    @objc func getNewResults() {
        self.flickerPercent = model.flickerPercent * 100
        self.flickerIndex = model.flickerIndex * 100
        self.hertz = model.hertz
    }
    
    func calculateResults() {
        model.setMatrixForAnalysis()
        model.calculateFlickerPercent()
        model.calculateFlickerIndex()
    }

}
    

    
    
