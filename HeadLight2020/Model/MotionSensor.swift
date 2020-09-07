//
//  MotionSensor.swift
//  HeadLight2020
//
//  Created by Ingrid on 22/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import CoreMotion


class MotionSensor {
    
    let motion = CMMotionManager()
    
    init() {

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
                if isStillArray.count < 4 {
                    if (abs(mRotationRate.x)) > 0.15 || abs(mRotationRate.y) > 0.15 || abs(mRotationRate.z) > 0.15 {
                        isStillArray.append(false)
                    }
                    else {
                        isStillArray.append(true)
                    }
                }
                
                //When analysis array is full and needs to be gradually filled with new data
                if isStillArray.count >= 4 {
                    if (abs(mRotationRate.x)) > 0.15 || abs(mRotationRate.y) > 0.15 || abs(mRotationRate.z) > 0.15 {
                        isStillArray.removeFirst()
                        isStillArray.append(false)
                        //To alert with a toast that phone is in motion
                        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "phoneIsNotStill"), object: nil)
                    }
                    else {
                        isStillArray.removeFirst()
                        isStillArray.append(true)
                    }
                    
                    if isStillArray.allSatisfy({$0}){
                        self.motion.stopDeviceMotionUpdates()
                        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "calculateResults"), object: nil)
                    }
                }
            }
        }
    }
    
    func interruptMotionSensor() {
        motion.stopDeviceMotionUpdates()
    }
}
