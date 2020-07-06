//
//  ViewController.swift
//  HeadLight2020
//
//  Created by Ingrid on 30/06/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let displayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let circle: UIBezierPath = {
        let circlePath = UIBezierPath()
        return circlePath
    }()
    
    let captureButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "accentLight")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.init(named: "mainColor")?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    //In order to set up camera
    var cameraDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Camera setup
        cameraSetup()
        
        self.view.addSubview(topPanelView)
        self.view.addSubview(displayView)
        displayView.addSubview(captureButton)


        setupLayoutConstraints()
    }
 
    func cameraSetup() {
       let captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high

        let videoDeviceDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)

        for camera in videoDeviceDiscovery.devices as [AVCaptureDevice] {
            if camera.position == .back {
                cameraDevice = camera
            }
            if cameraDevice == nil {
                print("Could not find back camera.")
            }
        }
        
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: cameraDevice!)
            if captureSession.canAddInput(videoDeviceInput) {
                captureSession.addInput(videoDeviceInput)
            }
        } catch {
            print("Could not add camera as input: \(error)")
            return
        }
        
        //Configuration of camera device to a 240 fps camera
        configureDevice()

        let previewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.view.bounds
        if (previewLayer.connection?.isVideoOrientationSupported)! {
            previewLayer.connection?.videoOrientation = .portrait
        }
        self.view.layer.addSublayer(previewLayer)
        
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
        
        //starts the camera
        captureSession.startRunning()
    }
    
    //Selects the function of the camera to be 240 fps
    func configureDevice() {
         if let camera = cameraDevice {

             for vFormat in cameraDevice!.formats {
                 let ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
                 let frameRates = ranges[0]
                 if frameRates.maxFrameRate == 240 {
                     do {
                         try camera.lockForConfiguration()
                             camera.activeFormat = vFormat as AVCaptureDevice.Format
                             camera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                             camera.activeVideoMaxFrameDuration = frameRates.minFrameDuration
                             camera.unlockForConfiguration()
                     }
                     catch {
                        print("camera not found")
                    }
                 }
             }
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
    
    private func setupLayoutConstraints() {
        let screenHeight = CGFloat(view.frame.height)
        let displayViewPortionOfScreen = CGFloat(0.2)
        
        //Constraints of top panel
        topPanelView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topPanelView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topPanelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topPanelView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        //Constraints of bottom display
        displayView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        displayView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        displayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        displayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: displayViewPortionOfScreen).isActive = true
        
        //Places decorative circle around capture button
        let x = view.frame.width / 2
        let y = view.frame.height * 0.9
        circle.addArc(withCenter: CGPoint(x: x, y: y), radius: CGFloat(screenHeight * displayViewPortionOfScreen * 0.25 + 2), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)


        let shapeLayer = CAShapeLayer()

            
        // Change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        // You can change the stroke color
        shapeLayer.strokeColor = UIColor(named: "accentLight")?.cgColor
        // You can change the line width
        shapeLayer.lineWidth = 5
        
        shapeLayer.path = circle.cgPath
        
        view.layer.addSublayer(shapeLayer)
            
        
        //Constraints of capture button
        captureButton.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        captureButton.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        captureButton.heightAnchor.constraint(equalTo: displayView.heightAnchor, multiplier: 0.5).isActive = true
        captureButton.widthAnchor.constraint(equalTo: displayView.heightAnchor, multiplier: 0.5).isActive = true
        //Ensures button is round on all screen sizes
        captureButton.layer.cornerRadius = screenHeight * displayViewPortionOfScreen * 0.25


    }

}

