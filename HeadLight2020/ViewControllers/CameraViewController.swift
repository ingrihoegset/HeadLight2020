//
//  ViewController.swift
//  HeadLight2020
//
//  Created by Ingrid on 30/06/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit
import AVFoundation

let semaphore = DispatchSemaphore(value: 0)

class CameraViewController: UIViewController {
    
    let viewModel = CameraViewModel(model: Model())
    
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
    
    let temporaryResultsView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.textAlignment = .center
        view.textColor = UIColor(named: "accentLight")
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.view.addSubview(temporaryResultsView)
        displayView.addSubview(captureButton)

        setupLayoutConstraints()
    }
 
    func cameraSetup() {
        let captureSession = viewModel.captureSession
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
        
        //Temporary results display
        temporaryResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temporaryResultsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temporaryResultsView.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.1).isActive = true
        temporaryResultsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        //Places decorative circle around capture button
        let x = view.frame.width / 2
        let y = view.frame.height * 0.9
        circle.addArc(withCenter: CGPoint(x: x, y: y), radius: CGFloat(screenHeight * displayViewPortionOfScreen * 0.25 + 2), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()

        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(named: "accentLight")?.cgColor
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
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        captureButton.addGestureRecognizer(longGesture)
    }
    

    @objc func longTap(_ sender: UIGestureRecognizer){
        captureButton.backgroundColor = UIColor(named: "mainColor")
        //This code runs when the button is released
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            captureButton.backgroundColor = UIColor(named: "accentLight")
            viewModel.interruptAnalysis()
            getNewResults()
            calculateResults()
        }
        //This code runs as long as the capture button is being held down
        else if sender.state == .began {
            viewModel.startAnalysis()
            print("UIGestureRecognizerStateBegan.")
        }
    }
    
    func segueToResults() {
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    func getNewResults() {
        temporaryResultsView.text = String(viewModel.flickerResult)
    }
    
    func calculateResults() {
        viewModel.calculateResults()
    }

}

