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


    let model = Model()
    let captureSession: AVCaptureSession
    var flickerResult: String
    
    init() {
        
        self.captureSession = model.captureSession
        self.flickerResult = String(model.flickerResults)
    }
    
    func startAnalysis() {
        model.startAnalysis()
    }
    
    func interruptAnalysis() {
        model.interruptAnalysis()
    }
  
}
    

    
    
