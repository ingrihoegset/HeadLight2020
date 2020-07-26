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
let sizeOfCaptureButton = Constants.displayViewPortionOfScreen * 0.5

class CameraViewController: UIViewController {
    
    let viewModel = CameraViewModel(model: Model(cameraCapture: CameraCapture()))
    
    let displayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColorTinted")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let captureButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "accentLight")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.init(named: "mainColor")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = sizeOfCaptureButton * 0.5
        return button
    }()
    
    let helper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let decorativeCircle: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor(named: "accentLight")?.cgColor
        shapeLayer.lineWidth = 8
        //decorative circle around capture button Center is half of button height and width
        let x = sizeOfCaptureButton * 0.5
        print(x)
        let y = sizeOfCaptureButton * 0.5
                print(y)
        let circle = UIBezierPath()
        circle.addArc(withCenter: CGPoint(x: x, y: y), radius: CGFloat(sizeOfCaptureButton * 0.5 + 2), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer.path = circle.cgPath
        return shapeLayer
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "Headlight"
        label.textColor = UIColor(named: "accentLight")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-ExtraLight", size: 20)
        return label
    }()
    
    let captureAnimation: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor(named: "mainContrastColor")?.cgColor
        layer.isHidden = true
        let size = CGFloat(25)
        layer.path = CGPath(ellipseIn: CGRect(x: -size / 2, y: ( -CGFloat(sizeOfCaptureButton) / 2) - size / 2 - 5, width: size, height: size), transform: nil)
        let circleCenter = CGPoint(x: CGFloat(sizeOfCaptureButton / 2), y: CGFloat(sizeOfCaptureButton / 2))
        layer.position = circleCenter
        return layer
    }()
    
    //In order to set up camera
    var cameraDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        
        //Camera setup
        cameraSetup()
        
        self.view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        self.view.addSubview(displayView)
        displayView.addSubview(helper)
        helper.layer.addSublayer(decorativeCircle)
        helper.layer.addSublayer(captureAnimation)
        helper.addSubview(captureButton)

        setupLayoutConstraints()

        NotificationCenter.default.addObserver(self, selector: #selector(segueToResults), name: NSNotification.Name.init(rawValue: "segueToResults"), object: nil)
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
        //Constraints of top panel
        topPanelView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topPanelView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topPanelView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topPanelView.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        
        //Top panel title
        titleLabel.centerXAnchor.constraint(equalTo: topPanelView.centerXAnchor
        ).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: topPanelView.heightAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: topPanelView.centerYAnchor).isActive = true
        
        //Constraints of bottom display
        displayView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        displayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        displayView.heightAnchor.constraint(equalToConstant: Constants.displayViewPortionOfScreen).isActive = true
    
        //Constraints of capture button
        captureButton.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        captureButton.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        captureButton.heightAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        captureButton.widthAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        captureButton.addGestureRecognizer(longGesture)

        //helper display box
        helper.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        helper.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        helper.heightAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        helper.widthAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
    }
    

    @objc func longTap(_ sender: UIGestureRecognizer){
        captureButton.backgroundColor = UIColor(named: "mainColor")
        decorativeCircle.strokeColor = UIColor(named: "accentLight")?.cgColor
        captureAnimation.isHidden = false
        
        //This code runs when the button is released
        if sender.state == .ended {
            captureButton.backgroundColor = UIColor(named: "accentLight")
            decorativeCircle.strokeColor = UIColor(named: "accentLight")?.cgColor
            captureAnimation.removeAnimation(forKey: "basic")
            captureAnimation.isHidden = true
            viewModel.interruptMotionSensor()
        }
        //This code runs as long as the capture button is being held down
        else if sender.state == .began {
            viewModel.startMotionSensor()
            captureAnimation(layer: captureAnimation)
        }
        else {
            viewModel.interruptMotionSensor()
            captureButton.backgroundColor = UIColor(named: "accentLight")
            decorativeCircle.strokeColor = UIColor(named: "accentLight")?.cgColor
            captureAnimation.isHidden = true
            captureAnimation.removeAnimation(forKey: "basic")
        }
    }
    
    @objc func segueToResults() {
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    //Sender relevant data til resultatVC når destinasjonen til segue'en er ResultsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ResultsViewController
        {
            print(viewModel.flickerPercent)
            let destinationViewController = segue.destination as? ResultsViewController
            destinationViewController?.flickerIndex = viewModel.flickerIndex
            destinationViewController?.hertz = viewModel.hertz
            destinationViewController?.flickerPercent = viewModel.flickerPercent
        }
    }
    
    func captureAnimation(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * CGFloat.pi
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 1.2
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "basic")
    }
}

