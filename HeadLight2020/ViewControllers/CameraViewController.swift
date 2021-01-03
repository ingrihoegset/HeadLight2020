//
//  ViewController.swift
//  HeadLight2020
//
//  Created by Ingrid on 30/06/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit
import AVFoundation
import SideMenu
import StoreKit
import Charts

let sizeOfCaptureButton = Constants.displayViewPortionOfScreen * 0.5

class CameraViewController: UIViewController, MenuControllerDelegate, SKPaymentTransactionObserver {
    
    var sideMenu: UISideMenuNavigationController?
    let howToUseController = HowToUseController()
    let healthInfoController = HealthInfoViewController()
    let tipsController = TipsViewController()
    let aboutController = AboutViewController()
    let welcomePresenter = WelcomePresenter()
    let welcomePage = WelcomePage()
    let restoreController = RestoreController()
    
    var freeSpinCounter = UserDefaults.standard.integer(forKey: Constants.userDefaultCounter)
    
    //Related to purchases
    let userDefaultCounter = UserDefaults.standard
    let userDefaultPurchased = UserDefaults.standard

    let viewModel = CameraViewModel(fourierModel: FourierModel(cameraCapture: CameraCapture()))
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        infoPopUp()
    }
    
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
        button.layer.borderWidth = 2
        button.layer.cornerRadius = sizeOfCaptureButton * 0.5
        return button
    }()
    
    let helper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let decorativeCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = sizeOfCaptureButton * 1.2 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "Headlight"
        label.textColor = UIColor(named: "accentLight")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.logoFont
        return label
    }()
    
    let hertzLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "whiteTinted")
        label.text = "hertz"
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.displayViewPortionOfScreen * 0.15 / 2
        label.clipsToBounds = true
        label.textColor = UIColor(named: "mainColorAccentDark")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.readingFontSmall
        return label
    }()
    
    let captureAnimation: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor(named: "mainColorAccentDark")?.cgColor
        layer.isHidden = true
        let sizeOfOuterCircle = sizeOfCaptureButton * 1.2
        let endAnimation = 1.2
        let size = ((sizeOfOuterCircle * CGFloat(endAnimation) - sizeOfCaptureButton) / 2)
        layer.path = CGPath(ellipseIn: CGRect(x: -size / 2, y: (-CGFloat(sizeOfOuterCircle * CGFloat(endAnimation)) / 2), width: size, height: size), transform: nil)
        let circleCenter = CGPoint(x: CGFloat((sizeOfCaptureButton) / 2), y: CGFloat(sizeOfCaptureButton / 2))
        layer.position = circleCenter
        return layer
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView(frame: .zero, title: "", text: "")
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.layer.cornerRadius = Constants.radiusContainers
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textView.textAlignment = .center
        view.delegate = self
        
        return view
    }()
    
    lazy var popUpViewBuyAccess: PopUpView = {
        let view = PopUpView(frame: .zero, title: "", text: "")
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.layer.cornerRadius = Constants.radiusContainers
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textView.textAlignment = .center
        view.delegate = self
        
        return view
    }()
    
    let detectionModeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "mainColor")
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.flickerIndicator
        label.font = Constants.readingFont
        label.textColor =  UIColor(named: "accentLight")
        view.addSubview(label)
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.seperator).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        return view
    }()
    
    let freeSpinIndicator: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.borderColor = UIColor(named: "accentLight")?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = Constants.displayViewPortionOfScreen * 0.4 / 2
        view.layer.masksToBounds = true
        view.titleLabel?.isUserInteractionEnabled = false
        view.titleLabel?.font = Constants.pageHeaderFont
        view.titleLabel?.textColor = UIColor(named: "mainColor")
        view.setTitleColor(UIColor(named: "mainColor"), for: .normal)
        view.addTarget(self, action: #selector(remainingPopUp), for: .touchUpInside)
        return view
    }()
    
    
    lazy var waveChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.enabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.gridColor = .clear
        chartView.xAxis.axisLineColor = .clear
        chartView.xAxis.axisLineWidth = 1
        chartView.xAxis.axisMaximum = 125
        chartView.xAxis.axisMinimum = -5
        chartView.legend.enabled = false
        chartView.minOffset = 0
        chartView.gridBackgroundColor = .yellow
        chartView.noDataText = ""
        
        return chartView
    }()
    
    //In order to set up camera
    var cameraDevice: AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For payments
        SKPaymentQueue.default().add(self)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(correctCapturePop))
        captureButton.addGestureRecognizer(tapGesture)

        
        //If user has made purchase
        if (isPurchased() == true) {
            freeSpinIndicator.setImage(UIImage(named: "Star"), for: .normal)
            captureButton.addGestureRecognizer(longGesture)
        }
            //If user has not made purchase
        else {
            //User still has remaining free spins
            if (checkIfMoreFreeSpins() == true) {
                captureButton.addGestureRecognizer(longGesture)
                let remainingSpins = String(Constants.totalFreeSpins - userDefaultCounter.integer(forKey: Constants.userDefaultCounter))
                freeSpinIndicator.setTitle(remainingSpins, for: .normal)
            }
            //User does not have remaining free spins
            else {
                //Indicates no more remaining spins
                freeSpinIndicator.setTitle("0", for: .normal)
                
                //remove any gestures
                if let gestures = captureButton.gestureRecognizers //first be safe if gestures are there
                {
                    for gesture in gestures //get one by one
                    {
                        captureButton.removeGestureRecognizer(gesture) //remove gesture one by one
                    }
                }
                //adds action that will trigger purchase box
                captureButton.addTarget(self, action: #selector(buyMoreAccess), for: .allTouchEvents)
            }
        }
 
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        let menu = MenuListController()
        menu.delegate = self
        sideMenu = UISideMenuNavigationController(rootViewController: menu)
        sideMenu?.setNavigationBarHidden(true, animated: false)
        sideMenu?.leftSide = true
        SideMenuManager.default.menuLeftNavigationController = sideMenu
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)

        //Checks status of user camera access and starts camera set up if user has granted access
        //Gives user directions to give camera access if this is not already given
        cameraSetup()
        
        self.view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)

        self.view.addSubview(displayView)
        displayView.addSubview(helper)
        //displayView.addSubview(hertzLabel)
        helper.addSubview(decorativeCircle)
        helper.layer.addSublayer(captureAnimation)
        helper.addSubview(captureButton)
        displayView.addSubview(freeSpinIndicator)
        self.view.addSubview(detectionModeView)
        
        //self.view.addSubview(waveChartView)
        
        setupLayoutConstraints()
        addChildControllers()
    
        //setDummyValuesForChart()
        
        detectionModeView.isHidden = true
        
        if (firstLaunch() == true) {
            showIntroSides()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(segueToResults), name: NSNotification.Name.init(rawValue: "segueToResults"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(holdPhoneStillToast), name: NSNotification.Name.init(rawValue: "holdPhoneStillToast"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setDataForWaveChart), name: NSNotification.Name.init(rawValue: "waveDataReady"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        viewModel.interruptMotionSensor()
        captureButton.backgroundColor = UIColor(named: "accentLight")
        decorativeCircle.backgroundColor = UIColor(named: "accentLight")
        removeCaptureAnimation(view: decorativeCircle)
        captureAnimation.isHidden = true
        captureAnimation.removeAnimation(forKey: "basic")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if (isPurchased() == true) {
            //do nothing
        }
        else {
            if (checkIfMoreFreeSpins() == false) {
                if let gestures = captureButton.gestureRecognizers //first be safe if gestures are there
                {
                    for gesture in gestures //get one by one
                    {
                        captureButton.removeGestureRecognizer(gesture) //remove gesture one by one
                    }
                }
                captureButton.addTarget(self, action: #selector(buyMoreAccess), for: .allTouchEvents)
                freeSpinIndicator.setTitle(String(Constants.totalFreeSpins - userDefaultCounter.integer(forKey: Constants.userDefaultCounter)), for: .normal)
            }
            else {
                freeSpinIndicator.setTitle(String(Constants.totalFreeSpins - userDefaultCounter.integer(forKey: Constants.userDefaultCounter)), for: .normal)
            }
        }
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
    
     //Selects the function of the camera to be 240 fps
     func configureDeviceNoFlicker() {
         if let camera = cameraDevice {

             for vFormat in cameraDevice!.formats {
                 let ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
                 let frameRates = ranges[0]
                 if frameRates.maxFrameRate == 30 {
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
        topPanelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Top panel title
        titleLabel.centerXAnchor.constraint(equalTo: topPanelView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Constraints of bottom display
        displayView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        displayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        displayView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        displayView.heightAnchor.constraint(equalToConstant: Constants.displayViewPortionOfScreen).isActive = true
        
        /*
        //hertz lable
        hertzLabel.trailingAnchor.constraint(equalTo: displayView.trailingAnchor, constant: -Constants.seperator).isActive = true
        hertzLabel.topAnchor.constraint(equalTo: displayView.topAnchor, constant: Constants.seperator * 2).isActive = true
        hertzLabel.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        hertzLabel.heightAnchor.constraint(equalToConstant: Constants.displayViewPortionOfScreen * 0.15).isActive = true
        
        // Wave chart
        waveChartView.bottomAnchor.constraint(equalTo: displayView.topAnchor, constant: 16).isActive = true
        waveChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        waveChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        waveChartView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        */

        //Constraints of capture button
        captureButton.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        captureButton.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        captureButton.heightAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        captureButton.widthAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        
        freeSpinIndicator.widthAnchor.constraint(equalToConstant: Constants.displayViewPortionOfScreen * 0.4).isActive = true
        freeSpinIndicator.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        freeSpinIndicator.trailingAnchor.constraint(equalTo: decorativeCircle.centerXAnchor, constant: -Constants.widthOfDisplay * 0.2).isActive = true
        freeSpinIndicator.heightAnchor.constraint(equalToConstant: Constants.displayViewPortionOfScreen * 0.4).isActive = true

        //helper display box
        helper.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        helper.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
        helper.heightAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        helper.widthAnchor.constraint(equalToConstant: sizeOfCaptureButton).isActive = true
        
        decorativeCircle.centerYAnchor.constraint(equalTo: helper.centerYAnchor).isActive =  true
        decorativeCircle.centerXAnchor.constraint(equalTo: helper.centerXAnchor).isActive = true
        decorativeCircle.heightAnchor.constraint(equalToConstant: sizeOfCaptureButton * 1.2).isActive = true
        decorativeCircle.widthAnchor.constraint(equalToConstant: sizeOfCaptureButton * 1.2).isActive = true
        
        
        //Flicker detection
        detectionModeView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        detectionModeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detectionModeView.bottomAnchor.constraint(equalTo: displayView.topAnchor, constant: 0).isActive = true
        detectionModeView.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
         
    }
    
    @IBAction func didTapMenu() {
        present(sideMenu!, animated: true)
        handleDismissal()
    }

    @objc func longTap(_ sender: UIGestureRecognizer){
        if (AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized) {
            //check if user has access to analysis
               animateCaptureButtonSize(view: decorativeCircle)
               captureButton.backgroundColor = UIColor(named: "accentLight")
               decorativeCircle.backgroundColor = UIColor(named: "accentLight")
               captureAnimation.isHidden = false
               
               //This code runs when the button is released
               if sender.state == .ended {
                   removeCaptureAnimation(view: decorativeCircle)
                   captureButton.backgroundColor = UIColor(named: "accentLight")
                   decorativeCircle.backgroundColor = UIColor(named: "accentLight")
                   captureAnimation.removeAnimation(forKey: "basic")
                   captureAnimation.isHidden = true
                   viewModel.interruptMotionSensor()
               }
               //This code runs as long as the capture button is being held down
               else if sender.state == .began {
                   viewModel.startMotionSensor()
                   captureAnimation(layer: captureAnimation)
               }
        }
        else {
            //In case user has not given access to camera yet
            goToCamera()
        }
    }
    
    @objc func segueToResults() {
        handleDismissal()
        if (viewModel.lightDetected == false) {
            self.showToast(message: "No light detected", font: UIFont(name: "Poppins-Light", size: 18)!)
        }
        else {
            self.performSegue(withIdentifier: "goToResults", sender: self)
            self.usedFreeSpin()
        }
    }
    
    //Sender relevant data til resultatVC når destinasjonen til segue'en er ResultsVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ResultsViewController
        {
            let destinationViewController = segue.destination as? ResultsViewController
            destinationViewController?.flickerIndex = viewModel.flickerIndex
            destinationViewController?.hertz = viewModel.hertz
            destinationViewController?.flickerPercent = viewModel.flickerPercent
            destinationViewController?.luminance = viewModel.luminance
            destinationViewController?.state = viewModel.state
        }
    }
    
    func captureAnimation(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = CGFloat.pi
        animation.toValue =  3 * CGFloat.pi
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 0.9
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "basic")
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: {
            
            if named == Constants.home {
                self.howToUseController.view.isHidden = true
                self.healthInfoController.view.isHidden = true
                self.tipsController.view.isHidden =  true
                self.aboutController.view.isHidden = true
                self.restoreController.view.isHidden = true
            }
            
            else if named == Constants.howTo {
                self.howToUseController.view.isHidden = false
                self.healthInfoController.view.isHidden = true
                self.tipsController.view.isHidden =  true
                self.aboutController.view.isHidden = true
                self.restoreController.view.isHidden = true
            }
            
            else if named == Constants.health {
                self.howToUseController.view.isHidden = true
                self.healthInfoController.view.isHidden = false
                self.tipsController.view.isHidden =  true
                self.aboutController.view.isHidden = true
                self.restoreController.view.isHidden = true
            }
            
            else if named == Constants.tips {
                self.howToUseController.view.isHidden = true
                self.healthInfoController.view.isHidden = true
                self.tipsController.view.isHidden =  false
                self.aboutController.view.isHidden = true
                self.restoreController.view.isHidden = true
            }
                
            else if named == Constants.about {
                self.howToUseController.view.isHidden = true
                self.healthInfoController.view.isHidden = true
                self.tipsController.view.isHidden =  true
                self.aboutController.view.isHidden = false
                self.restoreController.view.isHidden = true
            }
            
            else if named == Constants.restore {
                self.howToUseController.view.isHidden = true
                self.healthInfoController.view.isHidden = true
                self.tipsController.view.isHidden =  true
                self.aboutController.view.isHidden = true
                self.restoreController.view.isHidden = false
            }
        })
    }
    
    func addChildControllers() {
        addChild(howToUseController)
        view.addSubview(howToUseController.view)
        howToUseController.view.frame = view.bounds
        howToUseController.didMove(toParent: self)
        howToUseController.view.isHidden = true
        
        addChild(healthInfoController)
        view.addSubview(healthInfoController.view)
        healthInfoController.view.frame = view.bounds
        healthInfoController.didMove(toParent: self)
        healthInfoController.view.isHidden = true
        
        addChild(tipsController)
        view.addSubview(tipsController.view)
        tipsController.view.frame = view.bounds
        tipsController.didMove(toParent: self)
        tipsController.view.isHidden = true
        
        addChild(aboutController)
        view.addSubview(aboutController.view)
        aboutController.view.frame = view.bounds
        aboutController.didMove(toParent: self)
        aboutController.view.isHidden = true
        
        addChild(welcomePresenter)
        view.addSubview(welcomePresenter.view)
        welcomePresenter.view.frame = view.bounds
        welcomePresenter.didMove(toParent: self)
        welcomePresenter.view.isHidden = true
        
        addChild(welcomePage)
        view.addSubview(welcomePage.view)
        welcomePage.view.frame = view.bounds
        welcomePage.didMove(toParent: self)
        welcomePage.view.isHidden = true
        
        addChild(restoreController)
        view.addSubview(restoreController.view)
        restoreController.view.frame = view.bounds
        restoreController.didMove(toParent: self)
        restoreController.view.isHidden = true
    }
    
    @objc func infoPopUp() {
        
        self.view.addSubview(popUpView)
        
        popUpView.titleLabel.text = HowToUseText.infoButtonTitle
        popUpView.textView.text = HowToUseText.infoButtonText

        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
        popUpView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.8).isActive = true
        
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {

            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    @objc func flickerDetectorOffInfoPop() {
        
        self.view.addSubview(popUpView)
        
        popUpView.titleLabel.text = HowToUseText.infoButtonTitle
        popUpView.textView.text = HowToUseText.infoButtonText

        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
        popUpView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.8).isActive = true
        
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {

            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    @objc func remainingPopUp() {
        
        self.view.addSubview(popUpView)
        popUpView.titleLabel.text = Constants.freeSpinsRemainingTitle
        
        if (isPurchased() == true) {
            popUpView.textView.text = Constants.unlimitedAccessText
            popUpView.titleLabel.text = Constants.unlimitedAccessTitle   
        }
        else {
            let remainingSpins = Constants.totalFreeSpins - userDefaultCounter.integer(forKey: Constants.userDefaultCounter)
            let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.center
            
            let attributedText = NSMutableAttributedString(string: "You have ", attributes: [NSAttributedString.Key.font: Constants.readingFont!, NSAttributedString.Key.paragraphStyle : paragraphStyle])
            attributedText.append(NSAttributedString(string: String(remainingSpins), attributes: [NSAttributedString.Key.font: Constants.readingFont!, NSAttributedString.Key.paragraphStyle : paragraphStyle]))
            if (remainingSpins == 1) {
                attributedText.append(NSAttributedString(string: " free trial remaining.", attributes: [NSAttributedString.Key.font: Constants.readingFont!, NSAttributedString.Key.paragraphStyle : paragraphStyle]))
            }
            else if (remainingSpins == 0) {
                attributedText.append(NSAttributedString(string: " free trials remaining. Press the camera button to get additional trials or premium access.", attributes: [NSAttributedString.Key.font: Constants.readingFont!, NSAttributedString.Key.paragraphStyle : paragraphStyle]))
            }
            else {
                attributedText.append(NSAttributedString(string: " free trials remaining.", attributes: [NSAttributedString.Key.font: Constants.readingFont!, NSAttributedString.Key.paragraphStyle : paragraphStyle]))
            }


            popUpView.textView.attributedText = attributedText
        }

        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
        popUpView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.8).isActive = true
        
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {

            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    @objc func correctCapturePop() {
        if (AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized) {
            self.view.addSubview(popUpView)
            popUpView.titleLabel.text = HowToUseText.correctCaptureTitle
            popUpView.textView.text = HowToUseText.correctCaptureText

            popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            popUpView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
            popUpView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.8).isActive = true
            
            popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            popUpView.alpha = 0
            
            UIView.animate(withDuration: 0.5) {

                self.popUpView.alpha = 1
                self.popUpView.transform = CGAffineTransform.identity
            }
        }
        else {
            //In case user has not given access to camera yet
            goToCamera()
        }
    }
    
    func animateCaptureButtonSize(view: UIView) {
        UIView.animate(withDuration: 0.15) {
            view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func removeCaptureAnimation(view: UIView){
        view.layer.removeAllAnimations()
        view.layer.removeAllAnimations()
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25) {
            view.transform = .identity
        }
    }
    
    // MARK: - In-App Purchase Methods
    @objc func buyMoreAccess() {
        self.view.addSubview(popUpViewBuyAccess)
        
        popUpViewBuyAccess.titleLabel.text = "Get more trials"
        popUpViewBuyAccess.textView.text = ""

        popUpViewBuyAccess.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpViewBuyAccess.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        popUpViewBuyAccess.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.6).isActive = true
        popUpViewBuyAccess.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.8).isActive = true
        
        let textView1: UITextView = {
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.backgroundColor = UIColor(named: "mainColorAccentLight")
            textView.font = Constants.readingFont
            textView.textAlignment = .center
            textView.text = "Test more lights by buying more trials."
            return textView
        }()
        
        popUpViewBuyAccess.addSubview(textView1)
        textView1.topAnchor.constraint(equalTo: popUpViewBuyAccess.titleLabel.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        textView1.widthAnchor.constraint(equalTo: popUpViewBuyAccess.widthAnchor, constant: -Constants.sideMargins * 2).isActive = true
        textView1.heightAnchor.constraint(equalTo: popUpViewBuyAccess.heightAnchor, multiplier: 0.2).isActive = true
        textView1.centerXAnchor.constraint(equalTo: popUpViewBuyAccess.centerXAnchor).isActive = true
        
        let button1: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(named: Constants.mainColor)
            button.setTitle("Get 6 more trials", for: .normal)
            button.titleLabel?.font = Constants.readingFont
            button.addTarget(self, action: #selector(buyMoreSpins), for: .touchUpInside)
            return button
        }()
        
        popUpViewBuyAccess.addSubview(button1)
        button1.topAnchor.constraint(equalTo: textView1.bottomAnchor).isActive = true
        button1.widthAnchor.constraint(equalTo: popUpViewBuyAccess.widthAnchor, constant: -Constants.verticalMargins * 2).isActive = true
        button1.heightAnchor.constraint(equalTo: popUpViewBuyAccess.heightAnchor, multiplier: 0.15).isActive = true
        button1.centerXAnchor.constraint(equalTo: popUpViewBuyAccess.centerXAnchor).isActive = true
        button1.layer.cornerRadius = Constants.heightOfDisplay * 0.6 * 0.075
        
        let textView2: UITextView = {
            let textView = UITextView()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.backgroundColor = UIColor(named: "mainColorAccentLight")
            textView.font = Constants.readingFont
            textView.textAlignment = .center
            textView.text = "Test as many lights as you want with unlimited access."
            return textView
        }()
        
        let button2: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(named: Constants.mainColor)
            button.setTitle("Get unlimited access", for: .normal)
            button.clipsToBounds = true
            button.titleLabel?.font = Constants.readingFont
            button.layer.cornerRadius = Constants.radiusContainers
            button.addTarget(self, action: #selector(buyFullAccess), for: .touchUpInside)
            return button
        }()
        
        popUpViewBuyAccess.addSubview(button2)
        popUpViewBuyAccess.addSubview(textView2)
        textView2.bottomAnchor.constraint(equalTo: button2.topAnchor).isActive = true
        textView2.widthAnchor.constraint(equalTo: popUpViewBuyAccess.widthAnchor, constant: -Constants.sideMargins * 2).isActive = true
        textView2.heightAnchor.constraint(equalTo: popUpViewBuyAccess.heightAnchor, multiplier: 0.2).isActive = true
        textView1.centerXAnchor.constraint(equalTo: popUpViewBuyAccess.centerXAnchor).isActive = true
        
        button2.bottomAnchor.constraint(equalTo: popUpViewBuyAccess.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        button2.widthAnchor.constraint(equalTo: popUpViewBuyAccess.widthAnchor, constant: -Constants.verticalMargins * 2).isActive = true
        button2.heightAnchor.constraint(equalTo: popUpViewBuyAccess.heightAnchor, multiplier: 0.15).isActive = true
        button2.centerXAnchor.constraint(equalTo: popUpViewBuyAccess.centerXAnchor).isActive = true
        button2.layer.cornerRadius = Constants.heightOfDisplay * 0.6 * 0.075

        
        popUpViewBuyAccess.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpViewBuyAccess.alpha = 0
        
        UIView.animate(withDuration: 0.5) {

            self.popUpViewBuyAccess.alpha = 1
            self.popUpViewBuyAccess.transform = CGAffineTransform.identity
        }

    }
    
    @objc func buyFullAccess() {
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = Constants.fullAccess
            SKPaymentQueue.default().add(paymentRequest)
        }
        else {
            print("User can't make payments.")
        }
    }
    
    @objc func buyMoreSpins() {
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = Constants.moreSpins
            SKPaymentQueue.default().add(paymentRequest)
        }
        else {
            print("User can't make payments.")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {
            if transaction.transactionState == .purchased {
                SKPaymentQueue.default().finishTransaction(transaction)
                if (transaction.payment.productIdentifier == Constants.fullAccess) {
                    giveFullAcces()
                }
                if (transaction.payment.productIdentifier == Constants.moreSpins) {
                    giveMoreSpins()
                }
                handleDismissal()
                
                
            }
            else if transaction.transactionState == .failed {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
            else if transaction.transactionState == .restored {
                if (transaction.payment.productIdentifier == Constants.fullAccess) {
                    giveFullAcces()
                }
                if (transaction.payment.productIdentifier == Constants.moreSpins) {
                    giveMoreSpins()
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    func usedFreeSpin() {
        freeSpinCounter = freeSpinCounter + 1
        userDefaultCounter.set(self.freeSpinCounter, forKey: Constants.userDefaultCounter)

    }
    
    func checkIfMoreFreeSpins() -> Bool {
        if (Constants.totalFreeSpins - userDefaultCounter.integer(forKey: Constants.userDefaultCounter) <= 0) {
            return false
        }
        else {
            return true
        }
    }
    
    func giveFullAcces() {
        //Visual indication of premium access
        freeSpinIndicator.setTitle("", for: .normal)
        freeSpinIndicator.setImage(UIImage(named: "Star"), for: .normal)
        
        //Save purchased status permanently
        userDefaultPurchased.set(true, forKey: Constants.hasMadePurchase)
        
        //Remove buy action from capture button
        captureButton.removeTarget(self, action: #selector(buyMoreAccess), for: .allTouchEvents)
        
        //add back long gesture button so that the user can do analysis
        //add back tap gesture so that user gets info if doing the capture wrong
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        captureButton.addGestureRecognizer(longGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(correctCapturePop))
        captureButton.addGestureRecognizer(tapGesture)
    }
    
    func giveMoreSpins() {
        
        //Reset spins
        freeSpinCounter = 0
        userDefaultCounter.set(self.freeSpinCounter, forKey: Constants.userDefaultCounter)
        
        // Reset spin indicator Button
        let remainingSpins = String(Constants.totalFreeSpins - userDefaultCounter.integer(forKey: Constants.userDefaultCounter))
        freeSpinIndicator.setTitle(remainingSpins, for: .normal)
        
        //Remove buy action from capture button
        captureButton.removeTarget(self, action: #selector(buyMoreAccess), for: .allTouchEvents)
        
        //add back long gesture button so that the user can do analysis
        //add back tap gesture so that user gets info if doing the capture wrong
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        captureButton.addGestureRecognizer(longGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(correctCapturePop))
        captureButton.addGestureRecognizer(tapGesture)
    }
    
    func isPurchased() -> Bool {
        let purchasedStatus = UserDefaults.standard.bool(forKey: Constants.hasMadePurchase)
        return purchasedStatus
    }
    
    func firstLaunch() -> Bool{
        let userDefaultFirstLaunch = Constants.userDefaultFirstLaunch
        
        //Seems default value for bool is false before being set in else-bracket
        if (userDefaultFirstLaunch.bool(forKey: Constants.firstLaunch)) {
            return false
        }
        else {
            //Boolean is set to true when user clicks the "Let's Go!" button from the launch slide show.
            //I.e. it is set when the dismissView func is called from Welcome Presenter button
            return true
        }
    }
    
    func showIntroSides() {
        self.welcomePresenter.view.isHidden = false
        self.welcomePage.view.isHidden = false
    }
    
    func setDummyValuesForChart() {
        let entries = [ChartDataEntry(x: -5, y: 0.0), ChartDataEntry(x: 0, y: 0.00), ChartDataEntry(x: 125, y: 0)]
        let set = LineChartDataSet(entries: entries)
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 1
        set.setColor(.white)
        set.fill = Fill(color: UIColor(named: "whiteTinted")!)
        set.fillAlpha = 1
        set.drawFilledEnabled = true
        set.highlightEnabled = false
        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        self.waveChartView.data = data
    }
    
    @objc func setDataForWaveChart() {
        DispatchQueue.main.async {
            let entries = self.viewModel.allAmplitudes
            let set = LineChartDataSet(entries: entries)
            set.mode = .cubicBezier
            set.drawCirclesEnabled = false
            set.lineWidth = 1
            set.setColor(.white)
            set.fill = Fill(color: UIColor(named: "whiteTinted")!)
            set.fillAlpha = 1
            set.drawFilledEnabled = true
            set.highlightEnabled = false
            let data = LineChartData(dataSet: set)
            data.setDrawValues(false)
            self.waveChartView.data = data
        }
    }
    
    //Makes sure that user has given access to camera before setting up a camerasession
    func goToCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch (status) {
        case .authorized:
            self.cameraSetup()

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted) in
                if (granted)
                {
                    self.cameraSetup()
                }
                else
                {
                    self.camDenied()
                }
            }

        case .denied:
            self.camDenied()

        case .restricted:
            let alert = UIAlertController(title: "Restricted",
                                          message: "You've been restricted from using the camera on this device. Without camera access this app won't work. Please contact the device owner so they can give you access.",
                                          preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func camDenied() {
        DispatchQueue.main.async {
                var alertText = "It looks like your privacy settings are preventing us from accessing your camera. Headlight needs to access your camera to analyze your lighting. You can fix this error by doing the following steps:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Scroll to the bottom and select this app in the list.\n\n4. Turn the Camera on.\n\n5. Open this app and try again."

                var alertButton = "OK"
                var goAction = UIAlertAction(title: alertButton, style: .default, handler: nil)

                if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!)
                {
                    alertText = "It looks like your privacy settings are preventing us from accessing your camera. Headlight needs to access the camera to work. You can fix this error by doing the following steps:\n\n1. Touch the Go button below to open the Settings app.\n\n2. Turn the Camera on.\n\n3. Open this app and try again."

                    alertButton = "Go"

                    goAction = UIAlertAction(title: alertButton, style: .default, handler: {(alert: UIAlertAction!) -> Void in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    })
                }
                let alert = UIAlertController(title: "Error", message: alertText, preferredStyle: .alert)
                alert.addAction(goAction)
                self.present(alert, animated: true, completion: nil)
        }
    }
}


extension CameraViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height/2, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

extension CameraViewController {

    @objc func holdPhoneStillToast() {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height/2, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "Poppins-Light", size: 18)
        toastLabel.textAlignment = .center;
        toastLabel.text = "Hold phone still!"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension CameraViewController: PopUpDelegate {
    
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popUpViewBuyAccess.alpha = 0
            self.popUpViewBuyAccess.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpView.removeFromSuperview()
            self.popUpViewBuyAccess.removeFromSuperview()
        }
    }
}

