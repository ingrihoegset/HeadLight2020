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
    }
    
    //Calculates gray scale of pixel
    func getPixelNumber(byteBuffer: UnsafeMutablePointer<UInt8>, index: Int) -> Double{
        let b = byteBuffer[index]
        let bInt = Double(b)
        let g = byteBuffer[index + 1]
        let gInt = Double(g)
        let r = byteBuffer[index + 2]
        let rInt = Double(r)
        
        //Find the shade of gray represented by the rgb
        let gray = (bInt + gInt + rInt) / 3
        
        return gray
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
    
}
