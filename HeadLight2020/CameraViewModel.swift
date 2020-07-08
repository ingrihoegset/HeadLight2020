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
    var flickerResult: String
    
    init(model: Model) {
        
        self.model = model
        self.captureSession = model.captureSession
        self.flickerResult = String(model.flickerResults)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNewResults), name: NSNotification.Name.init(rawValue: "getNewResult"), object: nil)
    }
    
    func startAnalysis() {
        model.startAnalysis()
    }
    
    func interruptAnalysis() {
        model.interruptAnalysis()
    }
    
    @objc func getNewResults() {
        self.flickerResult = String(model.flickerResults)
    }
    
    func calculateResults() {
        model.calculateFlickerPercent()
    }

}
    

    
    
