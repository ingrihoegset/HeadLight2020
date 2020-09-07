//
//  CameraCapture.swift
//  HeadLight2020
//
//  Created by Ingrid on 21/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//


import Foundation
import AVFoundation

class CameraCapture: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate{
    
    let captureSession = AVCaptureSession()
    var counter = 0
    var secondCounter = 0
    
    //For Fourier
    var rowOfPixels = [Float]()
    var matrixOfPixelsFourier = [[Float]]()
    var rowOfPixelsVisuals = [Float]()
    var matrixOfPixelVisuals = [[Float]]()

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

        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        
        CVPixelBufferLockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
        
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)!
        let byteBuffer = baseAddress.assumingMemoryBound(to: UInt8.self)
        
        // ------ For Fourier Start ------- //
        rowOfPixels = []
        rowOfPixelsVisuals = []
        
        //Removes the oldest input from the matrix when the matrix reaches a certain size
        if(matrixOfPixelsFourier.count >= Constants.noOfFramesForAnalysis) {
            matrixOfPixelsFourier.removeFirst(1)
            matrixOfPixelVisuals.removeFirst(1)
        }
        
        //Chosen pixel for analysis
        //We are pointing to the location of the pixel in the memory space, and not to the coordinate on the image.
        //We therefore locate the pixel by going through a long memory array, rather than a coordinate on a (x,y) format.
        //To find the pixel at (1,0) point on the image means we have to find the pixel at the (width + 1) space in the array.
        //We have to increase the index by 4 to get to a new pixel in the array.
        //This is because every pixel is represented by 4 bits of memory, so to get to the next pixel, we must move
        //4 spaces down the array.
        //Returns array of 36 simultaneous pixels with leap of * 20 (for my screen size)
        for i in stride(from: 0, to: width * height * 4 - 1, by: width) {
            let pixel = getPixelNumber(byteBuffer: byteBuffer, index: i)
            rowOfPixels.append(pixel)
        }
        
        let pixelVisual = getPixelNumber(byteBuffer: byteBuffer, index: 0)
        rowOfPixelsVisuals.append(pixelVisual)
        
        //Adds the array of simultaneus pixels to the matrix
        matrixOfPixelsFourier.append(rowOfPixels)
        matrixOfPixelVisuals.append(rowOfPixelsVisuals)
        
        
        // ------ For Fourier END ------- //
        
        if (secondCounter == 360) {
            secondCounter = 0
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "getWaveData"), object: nil)
        }
        else {
            secondCounter = secondCounter + 1
        }

        //Dont know what this does, but dont move
        CVPixelBufferUnlockBaseAddress(imageBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))
    }
        
    //Calculates gray scale of pixel
    func getPixelNumber(byteBuffer: UnsafeMutablePointer<UInt8>, index: Int) -> Float {
        let b = byteBuffer[index]
        let bInt = Double(b)
        let g = byteBuffer[index + 1]
        let gInt = Double(g)
        let r = byteBuffer[index + 2]
        let rInt = Double(r)
        
        //Find the shade of gray represented by the rgb
        let gray = (bInt + gInt + rInt) / 3
        
        return Float(gray)
    }
    
    func getMatrixFourier() -> [[Float]] {
        return matrixOfPixelsFourier
    }
    
    func getMatrixForVisuals() -> [[Float]] {
        return matrixOfPixelVisuals
    }
}
