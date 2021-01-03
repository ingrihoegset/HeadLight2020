//
//  ResultsViewController.swift
//  HeadLight2020
//
//  Created by Ingrid on 06/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    var flickerPercent = 0.0
    var flickerIndex = 0.0
    var hertz = 0.0
    var luminance = 0.0
    let okColor = UIColor.systemYellow.cgColor
    var sideEffectsObjects = [MoreInfoObject]()
    var timerObjects = [MoreInfoObject]()
    var tipsObject = [MoreInfoObject]()
    var resultObjects = [UIView]()
    var state = State(type: "", overallTitle: "", overallImageName: "", overallIndicatorColorMain: "", overallIndicatorColorSub: "", exposureTime: "", indicatorTime: 0, indicatorColor: "", sideeffects: [], timerObject: [], tipsObject: [])
    let infoContainerHeight = Constants.heightOfDisplay * 0.18
    let heightOfTipsContainer = Constants.smallContainerDimensions * 1.9
    
    let overallResults: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = Constants.largeContainerDimension * 1 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "SecondWorst")
        view.image = image
        return view
    }()
    
    let overallResultsHelper: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = Constants.largeContainerDimension / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dayLightDisplay: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        label.layer.cornerRadius = Constants.radius
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "No"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Detectable" + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
        attributedText.append(NSAttributedString(string: "Flicker", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
        label.attributedText = attributedText
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        return label
    }()
    
    let percentResultsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Flicker"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Percent", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let hertzResultsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hertzLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Flicker"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Per Second", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let resultsDisplay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let detailCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColorAccentDark")
        view.layer.cornerRadius = Constants.radius + Constants.trackLayerLineWidth/2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resultsViewFlickerIndex: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultsViewHertz: UILabel = {
         let label = UILabel()
         label.backgroundColor = UIColor.clear
         label.textAlignment = .center
         label.textColor = .white
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     let resultsViewPercent: UILabel = {
         let label = UILabel()
         label.textAlignment = .center
         label.textColor = UIColor(named: "accentLight")
         label.translatesAutoresizingMaskIntoConstraints = false
         label.backgroundColor = .clear
         label.isUserInteractionEnabled = false
         return label
     }()
    
    //Underlying track for animation flicker percent
    let trackLayerPercent: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(named: "mainColorAccentLight")?.cgColor
        trackLayer.lineWidth = Constants.trackLayerLineWidth
        trackLayer.lineCap = .round
        return trackLayer
    }()
    
    let animationLayerPercent: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.lineWidth = Constants.trackLayerLineWidth
        animationLayer.strokeEnd = 0
        animationLayer.lineCap = .round
        animationLayer.strokeColor = UIColor.systemYellow.cgColor
        return animationLayer
    }()
    
    //Underlying track for animation flicker index
    let trackLayerFlickerIndex: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(named: "mainColorAccentLight")?.cgColor
        trackLayer.lineWidth = 8
        trackLayer.lineCap = .round
        return trackLayer
    }()
    
    let animationLayerFlickerIndex: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.lineWidth = 8
        animationLayer.strokeEnd = 0
        animationLayer.lineCap = .round
        animationLayer.strokeColor = UIColor.systemYellow.cgColor
        return animationLayer
    }()
    
    let infoContainer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.radiusContainers
        return view
    }()
    
    let infoContainerChevron: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right.circle.fill")
        imageView.image = image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "mainColorAccentDark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let infoContainerMoreInfoObjects: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.radiusContainers
        return view
    }()
    
    let moreInfoContainerChevron: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right.circle.fill")
        imageView.image = image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "mainColorAccentDark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let horizontalMoreInfoObjectsContainer: UIStackView = {
        let container = UIStackView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.alignment = .leading
        container.distribution = .fillEqually
        container.axis = .vertical
        return container
    }()
    
    let timerTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "accentLight")
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let timerView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.init(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        let image = UIImage(named: "Timer")
        view.image = image
        return view
    }()
    
    let tipsImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.init(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        let image = UIImage(named: "BlueCheck")
        view.image = image
        return view
    }()
    
    let MoreInfoObjectsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Possible Side Effects"
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        label.attributedText = attributedText
        return label
    }()
    
    let timerIndiatorContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timerTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 20
        layer.lineCap = .round
        layer.strokeColor = UIColor(named: "mainColorVeryTinted")?.cgColor
        return layer
    }()
    
    let timerFillerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.red.cgColor
        layer.lineWidth = 18
        layer.strokeEnd = 0
        layer.lineCap = .round
        layer.strokeColor = UIColor.systemYellow.cgColor
        return layer
    }()
    
    let tipsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.radiusContainers
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        return view
    }()
    
    let tipsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Tips for better lighting"
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        label.attributedText = attributedText
        return label
    }()
    
    let tipsContainerChevron: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right.circle.fill")
        imageView.image = image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(named: "mainColorAccentDark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView(frame: .zero, title: "Title")
        view.backgroundColor = UIColor(named: "mainColorAccentDark")
        view.layer.cornerRadius = Constants.radiusContainers
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    let timerSwiper: SwipingController = {
        let swiper = SwipingController(frame: .zero)
        swiper.backgroundColor = UIColor(named: "accentLight")
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()
    
    let MoreInfoObjectsSwiper: SwipingController = {
        let swiper = SwipingController(frame: .zero)
        swiper.backgroundColor = UIColor(named: "accentLight")
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()
    
    let tipsSwiper: SwipingController = {
        let swiper = SwipingController(frame: .zero)
        swiper.backgroundColor = UIColor(named: "accentLight")
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let thisLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        label.textColor = UIColor(named: "accentLight")
        label.text = "This"
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lightIsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.text = "Light is"
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lightQualityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        label.textColor = UIColor(named: "accentLight")
        label.text = "Good"
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let helperLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        return label
    }()
    
    let helperLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        return label
    }()
    
    let helperLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        return label
    }()
    
    let scrollView: FadeScrollView = {
        let scroller = FadeScrollView()
        scroller.backgroundColor = .clear
        scroller.translatesAutoresizingMaskIntoConstraints = false
        scroller.showsVerticalScrollIndicator = true
        return scroller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "mainColor")
        
        //If we cant have side effects.
        
        /*
        self.view.addSubview(infoContainer)
        infoContainer.addSubview(timerTitle)
        infoContainer.addSubview(infoContainerChevron)
        infoContainer.addSubview(timerView)
        infoContainer.addSubview(timerIndiatorContainer)
        
        self.view.addSubview(tipsContainer)
        tipsContainer.addSubview(tipsTitle)
        tipsContainer.addSubview(tipsContainerChevron)
        tipsContainer.addSubview(tipsImageView)*/
        
        //Regarding side effects
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(infoContainer)
        infoContainer.addSubview(timerTitle)
        infoContainer.addSubview(infoContainerChevron)
        infoContainer.addSubview(timerView)
        infoContainer.addSubview(timerIndiatorContainer)
        
        scrollView.addSubview(infoContainerMoreInfoObjects)
        infoContainerMoreInfoObjects.addSubview(MoreInfoObjectsTitle)
        infoContainerMoreInfoObjects.addSubview(horizontalMoreInfoObjectsContainer)
        infoContainerMoreInfoObjects.addSubview(moreInfoContainerChevron)
        
        scrollView.addSubview(tipsContainer)
        tipsContainer.addSubview(tipsTitle)
        tipsContainer.addSubview(tipsContainerChevron)
        tipsContainer.addSubview(tipsImageView)
        
        /*
        //For testing resultscreen without segueing through camera view
        
            let AvoidTimerObject = MoreInfoObject(frame: .zero, image: "Timer", title1: "", title2: "", moreInfoText: "This light is terrible. You should avoid this lighting.")
            //Tips
            let tip1 = MoreInfoObject(frame: .zero, image: "Introduction", title1: "", title2: "", moreInfoText: "This light is good and is not associated with increased risk of any negative side effects. Use Headlight to check other light sources in your working and living environment.")
            let vertigoLowRisk = MoreInfoObject(frame: .zero, image: "Dizzyness", title1: "Vertigo", title2: "", moreInfoText: MoreInfoObjectTexts.lowRiskVertigo, risk: 50)
            let indicatorGreen = "indicatorGreen"
            self.flickerIndex = 40.0
            self.hertz = 10.0
            self.flickerPercent = 30.0
            self.luminance = 20.0
            self.state =  State(type: "Best",
            overallTitle: "Great",
            overallImageName: "Best",
            overallIndicatorColorMain: Constants.green,
            overallIndicatorColorSub: Constants.green,
            exposureTime: "Unlimited", indicatorTime: 100,
            indicatorColor: indicatorGreen,
            sideeffects: [vertigoLowRisk],
            timerObject: [AvoidTimerObject],
            tipsObject: [tip1])*/
        
        
        let noOfSideeffects = state.sideeffects?.count
        let heightOfMoreInfoContainer = Constants.topMargin + Constants.smallContainerDimensions * CGFloat(noOfSideeffects!) * 1.75
        let spacing = 4 * Constants.verticalMargins
        let heightOfScrollView = infoContainerHeight + heightOfMoreInfoContainer + heightOfTipsContainer
        scrollView.contentSize = CGSize(width: Constants.widthOfDisplay, height: heightOfScrollView + spacing)
        
        setupLayoutConstraints()

        timerIndiatorContainer.layer.addSublayer(timerTrackLayer)
        timerIndiatorContainer.layer.addSublayer(timerFillerLayer)
        

        
        
        
        setState()
        getNewResults()
        
        //Needed to make animation render over other views
        view.bringSubviewToFront(overallResultsHelper)
        view.bringSubviewToFront(overallResults)
        
        makeGraphic(score: flickerPercent, trackLayer: trackLayerPercent, animationLayer: animationLayerPercent, duration: 2.5)
        makeGraphic(score: flickerIndex, trackLayer: trackLayerFlickerIndex, animationLayer: animationLayerFlickerIndex, duration: 1.5)
        
        //Event handlers
        let exposureTap = UITapGestureRecognizer(target: self, action: #selector(exposureTap(_:)))
        infoContainer.addGestureRecognizer(exposureTap)
        
        //Regarding Side Effects
        
        let MoreInfoObjectTap = UITapGestureRecognizer(target: self, action: #selector(MoreInfoObjectTap(_:)))
        infoContainerMoreInfoObjects.addGestureRecognizer(MoreInfoObjectTap)
        
        let tipsTap = UITapGestureRecognizer(target: self, action: #selector(tipsTap(_:)))
        tipsContainer.addGestureRecognizer(tipsTap)
    }
    
    private func constraintsResultDisplay() {
        resultsDisplay.addSubview(percentResultsContainer)
        percentResultsContainer.addSubview(percentLabel)
        percentResultsContainer.addSubview(resultsViewPercent)
        percentResultsContainer.layer.addSublayer(trackLayerPercent)
        percentResultsContainer.layer.addSublayer(animationLayerPercent)
         
        resultsDisplay.addSubview(hertzResultsContainer)
        hertzResultsContainer.addSubview(hertzLabel)
        hertzResultsContainer.addSubview(detailCircle)
        detailCircle.addSubview(resultsViewHertz)
        
        // percent results container
        percentResultsContainer.topAnchor.constraint(equalTo: resultsDisplay.topAnchor).isActive = true
        percentResultsContainer.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.seperator).isActive = true
        percentResultsContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        percentResultsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // percent title label
        percentLabel.centerXAnchor.constraint(equalTo: percentResultsContainer.centerXAnchor).isActive = true
        percentLabel.topAnchor.constraint(equalTo: percentResultsContainer.bottomAnchor, constant: -((Constants.containerDimension / 2) - Constants.radius)).isActive = true
        percentLabel.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        percentLabel.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // percent results display
        resultsViewPercent.centerYAnchor.constraint(equalTo: percentResultsContainer.centerYAnchor).isActive = true
        resultsViewPercent.centerXAnchor.constraint(equalTo: percentResultsContainer.centerXAnchor).isActive = true
        resultsViewPercent.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        resultsViewPercent.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // hertz results container
        hertzResultsContainer.topAnchor.constraint(equalTo: resultsDisplay.topAnchor).isActive = true
        hertzResultsContainer.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.seperator).isActive = true
        hertzResultsContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        hertzResultsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // hertz title label
        hertzLabel.centerXAnchor.constraint(equalTo: hertzResultsContainer.centerXAnchor).isActive = true
        hertzLabel.topAnchor.constraint(equalTo: hertzResultsContainer.bottomAnchor, constant: -((Constants.containerDimension / 2) - Constants.radius)).isActive = true
        hertzLabel.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        hertzLabel.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // hertz results display
        detailCircle.centerYAnchor.constraint(equalTo: hertzResultsContainer.centerYAnchor).isActive = true
        detailCircle.centerXAnchor.constraint(equalTo: hertzResultsContainer.centerXAnchor).isActive = true
        detailCircle.heightAnchor.constraint(equalToConstant: Constants.radius * 2 + Constants.trackLayerLineWidth).isActive = true
        detailCircle.widthAnchor.constraint(equalToConstant: Constants.radius * 2 + Constants.trackLayerLineWidth).isActive = true
        
        // hertz results display
        resultsViewHertz.centerYAnchor.constraint(equalTo: detailCircle.centerYAnchor).isActive = true
        resultsViewHertz.centerXAnchor.constraint(equalTo: detailCircle.centerXAnchor).isActive = true
        resultsViewHertz.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        resultsViewHertz.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
    }
    
    private func setupLayoutConstraints() {
        self.view.addSubview(thisLabel)
        self.view.addSubview(lightIsLabel)
        self.view.addSubview(lightQualityLabel)
        self.view.addSubview(helperLabel1)
        self.view.addSubview(helperLabel2)
        self.view.addSubview(helperLabel3)
        self.view.addSubview(overallResultsHelper)
        self.view.addSubview(overallResults)
        self.view.addSubview(resultsDisplay)
        
        // overall results display
        overallResults.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.sideMargins).isActive = true
        overallResults.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overallResults.heightAnchor.constraint(equalToConstant: Constants.largeContainerDimension * 1).isActive = true
        overallResults.widthAnchor.constraint(equalToConstant: Constants.largeContainerDimension * 1).isActive = true
        
        // overall results helper - purpose to create lalyer between animation
        overallResultsHelper.centerYAnchor.constraint(equalTo: overallResults.centerYAnchor).isActive = true
        overallResultsHelper.centerXAnchor.constraint(equalTo: overallResults.centerXAnchor).isActive = true
        overallResultsHelper.heightAnchor.constraint(equalToConstant: Constants.largeContainerDimension).isActive = true
        overallResultsHelper.widthAnchor.constraint(equalToConstant: Constants.largeContainerDimension).isActive = true
        
        //result labels
        lightIsLabel.leadingAnchor.constraint(equalTo: overallResultsHelper.trailingAnchor).isActive = true
        lightIsLabel.centerYAnchor.constraint(equalTo: overallResultsHelper.centerYAnchor).isActive = true
        lightIsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
        thisLabel.bottomAnchor.constraint(equalTo: lightIsLabel.topAnchor, constant: -Constants.sideMargins).isActive = true
        thisLabel.leadingAnchor.constraint(equalTo: overallResultsHelper.trailingAnchor).isActive = true
        thisLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        lightQualityLabel.topAnchor.constraint(equalTo: lightIsLabel.bottomAnchor, constant:  Constants.sideMargins).isActive = true
        lightQualityLabel.leadingAnchor.constraint(equalTo: overallResultsHelper.trailingAnchor).isActive = true
        lightQualityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        helperLabel1.leadingAnchor.constraint(equalTo: overallResultsHelper.centerXAnchor).isActive = true
        helperLabel1.trailingAnchor.constraint(equalTo: thisLabel.leadingAnchor).isActive = true
        helperLabel1.heightAnchor.constraint(equalTo: thisLabel.heightAnchor).isActive = true
        helperLabel1.centerYAnchor.constraint(equalTo: thisLabel.centerYAnchor).isActive = true
        
        helperLabel2.leadingAnchor.constraint(equalTo: overallResultsHelper.centerXAnchor).isActive = true
        helperLabel2.trailingAnchor.constraint(equalTo: lightIsLabel.leadingAnchor).isActive = true
        helperLabel2.heightAnchor.constraint(equalTo: lightIsLabel.heightAnchor).isActive = true
        helperLabel2.centerYAnchor.constraint(equalTo: lightIsLabel.centerYAnchor).isActive = true
        
        helperLabel3.leadingAnchor.constraint(equalTo: overallResultsHelper.centerXAnchor).isActive = true
        helperLabel3.trailingAnchor.constraint(equalTo: lightQualityLabel.leadingAnchor).isActive = true
        helperLabel3.heightAnchor.constraint(equalTo: lightQualityLabel.heightAnchor).isActive = true
        helperLabel3.centerYAnchor.constraint(equalTo: lightQualityLabel.centerYAnchor).isActive = true
        
        resultsDisplay.topAnchor.constraint(equalTo: overallResultsHelper.bottomAnchor, constant: Constants.verticalMargins * 0.5).isActive = true
        resultsDisplay.heightAnchor.constraint(equalToConstant: Constants.largeContainerDimension).isActive = true
        resultsDisplay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.verticalMargins).isActive = true
        resultsDisplay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.verticalMargins).isActive = true
    
        //Regarding side effects
        
        // scroll view
        scrollView.topAnchor.constraint(equalTo: resultsDisplay.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // info container timer
        infoContainer.heightAnchor.constraint(equalToConstant: infoContainerHeight).isActive = true
        infoContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
        infoContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.verticalMargins).isActive = true
        infoContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // timer title
        timerTitle.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: Constants.sideMargins).isActive = true
        timerTitle.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: Constants.seperator).isActive = true
        
        // info container chevron
        infoContainerChevron.centerYAnchor.constraint(equalTo: timerTitle.centerYAnchor).isActive = true
        infoContainerChevron.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -Constants.seperator).isActive = true
        infoContainerChevron.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 0.25).isActive = true
        infoContainerChevron.heightAnchor.constraint(equalToConstant: Constants.containerDimension * 0.25).isActive = true
        
        // timer image container
        timerView.topAnchor.constraint(equalTo: timerTitle.bottomAnchor, constant: Constants.sideMargins).isActive = true
        timerView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: Constants.seperator).isActive = true
        timerView.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        timerView.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // timer indicator container
        timerIndiatorContainer.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        timerIndiatorContainer.leadingAnchor.constraint(equalTo: timerView.trailingAnchor).isActive = true
        timerIndiatorContainer.centerYAnchor.constraint(equalTo: timerView.centerYAnchor).isActive = true
        timerIndiatorContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        let noOfSideEffects = state.sideeffects?.count
        let heightOfMoreInfoContainer = Constants.smallContainerDimensions * CGFloat(noOfSideEffects!)
        
        //Regarding side effects
        
        // info container side effects
        infoContainerMoreInfoObjects.heightAnchor.constraint(equalToConstant: Constants.topMargin + heightOfMoreInfoContainer * 1.75).isActive = true
        infoContainerMoreInfoObjects.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
        infoContainerMoreInfoObjects.topAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: Constants.sideMargins).isActive = true
        infoContainerMoreInfoObjects.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        // side effects title
        MoreInfoObjectsTitle.topAnchor.constraint(equalTo: infoContainerMoreInfoObjects.topAnchor, constant: Constants.sideMargins).isActive = true
        MoreInfoObjectsTitle.leadingAnchor.constraint(equalTo: infoContainerMoreInfoObjects.leadingAnchor, constant: Constants.seperator).isActive = true
        MoreInfoObjectsTitle.widthAnchor.constraint(equalTo: infoContainerMoreInfoObjects.widthAnchor).isActive = true
        
        // info container chevron
        moreInfoContainerChevron.centerYAnchor.constraint(equalTo: MoreInfoObjectsTitle.centerYAnchor).isActive = true
        moreInfoContainerChevron.trailingAnchor.constraint(equalTo: infoContainerMoreInfoObjects.trailingAnchor, constant: -Constants.seperator).isActive = true
        moreInfoContainerChevron.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 0.25).isActive = true
        moreInfoContainerChevron.heightAnchor.constraint(equalToConstant: Constants.containerDimension * 0.25).isActive = true
        
        //Side effects stack container
        horizontalMoreInfoObjectsContainer.topAnchor.constraint(equalTo: MoreInfoObjectsTitle.bottomAnchor, constant: Constants.sideMargins).isActive = true
        horizontalMoreInfoObjectsContainer.centerXAnchor.constraint(equalTo: infoContainerMoreInfoObjects.centerXAnchor).isActive = true
        horizontalMoreInfoObjectsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3 - 2 * Constants.seperator).isActive = true
        horizontalMoreInfoObjectsContainer.bottomAnchor.constraint(equalTo: infoContainerMoreInfoObjects.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        
        //tips container
        tipsContainer.topAnchor.constraint(equalTo: infoContainerMoreInfoObjects.bottomAnchor, constant: Constants.sideMargins).isActive = true
        tipsContainer.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions * 1.9).isActive = true
        tipsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
        tipsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //tips title
        tipsTitle.topAnchor.constraint(equalTo: tipsContainer.topAnchor, constant: Constants.sideMargins).isActive = true
        tipsTitle.leadingAnchor.constraint(equalTo: tipsContainer.leadingAnchor, constant: Constants.seperator).isActive = true
        tipsTitle.widthAnchor.constraint(equalTo: tipsContainer.widthAnchor).isActive = true
        
        // timer image container
        tipsImageView.topAnchor.constraint(equalTo: tipsTitle.bottomAnchor, constant: Constants.sideMargins).isActive = true
        tipsImageView.centerXAnchor.constraint(equalTo: tipsContainer.centerXAnchor).isActive = true
        tipsImageView.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        tipsImageView.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // tips container chevron
        tipsContainerChevron.centerYAnchor.constraint(equalTo: tipsTitle.centerYAnchor).isActive = true
        tipsContainerChevron.trailingAnchor.constraint(equalTo: tipsContainer.trailingAnchor, constant: -Constants.seperator).isActive = true
        tipsContainerChevron.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 0.25).isActive = true
        tipsContainerChevron.heightAnchor.constraint(equalToConstant: Constants.containerDimension * 0.25).isActive = true
    }
    
    func getNewResults() {

        let flickerPercentText = String(format: "%.0f", flickerPercent)
        let flickerPercentAttributedText = NSMutableAttributedString(string: flickerPercentText + " %", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        resultsViewPercent.attributedText = flickerPercentAttributedText
        
        let hertzText = String(format: "%.0f", hertz)
        let hertzAttributedText = NSMutableAttributedString(string: hertzText, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        resultsViewHertz.attributedText = hertzAttributedText
    }
    
    func makeGraphic(score: Double, trackLayer: CAShapeLayer, animationLayer: CAShapeLayer, duration: Double) {

        //Location for track and for animation
        let center = CGPoint(x: Constants.containerDimension * 0.5, y: Constants.containerDimension * 0.5)

        //Path for animation and underlying path
        let circularPath = UIBezierPath(arcCenter: center, radius: CGFloat(Constants.radius), startAngle: (3 * CGFloat.pi) / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        animationLayer.path = circularPath.cgPath
        
        var scale = CGFloat(0)
        if (score > 50) {
            scale = 1
        }
        else {
           scale = CGFloat(score / 50)
        }

        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0.01
        basicAnimation.toValue = scale
        basicAnimation.duration = duration
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animationLayer.add(basicAnimation, forKey: "basic")
    }
    
    func makeTimerGraphic(score: Double, track: CAShapeLayer, filler: CAShapeLayer) {
        
         let endpoint = score / 100
         let startOfPathX = 0 + Constants.sideMargins * 2
         let endOfPathX = Constants.containerDimension * 2
         let segmentSize = (endOfPathX - startOfPathX) / 4

         let path = UIBezierPath()
         
         var segments: [CAShapeLayer] = []
         
         for i in 0...3 {
             
             let layer = CAShapeLayer()
             let gapSize: CGFloat = segmentSize * 0.40
             
             path.move(to: CGPoint(x: startOfPathX + segmentSize * CGFloat(i), y: Constants.smallContainerDimensions * 0.5))
             path.addLine(to: CGPoint(x: startOfPathX + segmentSize * CGFloat(i) + segmentSize - gapSize , y: Constants.smallContainerDimensions * 0.5))
             layer.path = path.cgPath
             
             layer.strokeColor = UIColor(named: "mainColorVeryTinted")?.cgColor
             
    
             layer.lineCap = .round
             layer.lineWidth = 20
             
             // add the segment to the segments array and to the view
             segments.insert(layer, at: i)
             
             self.timerIndiatorContainer.layer.addSublayer(segments[i])

         }
             
             if (endpoint <= 0.25) {
                 timerFillerLayer.strokeColor = UIColor(named: "darkRed")?.cgColor
             }
             else if (endpoint <= 0.50) {
                 timerFillerLayer.strokeColor = UIColor.red.cgColor
             }
             else if (endpoint <= 0.75) {
                 timerFillerLayer.strokeColor = UIColor.yellow.cgColor
             }
             else {
                timerFillerLayer.strokeColor = UIColor.green.cgColor
             }
             timerIndiatorContainer.layer.addSublayer(timerFillerLayer)
                 
             filler.path = path.cgPath
    
        let barAnimation = CABasicAnimation(keyPath: "strokeEnd")
        if endpoint == 0 {
            barAnimation.toValue = endpoint + 0.01
        }
        else {
            barAnimation.toValue = endpoint
        }
        barAnimation.duration = 2.0
        barAnimation.fillMode = CAMediaTimingFillMode.forwards
        barAnimation.isRemovedOnCompletion = false
        filler.add(barAnimation, forKey: "basic")
    }
    
    func setState() {
        constraintsResultDisplay()

        setDisplay(resultIcon: state.overallImageName!, resultAnimationColor1: state.overallIndicatorColorMain!, resultAnimationColor2: state.overallIndicatorColorSub!, timerTime: state.exposureTime!, timerIndication: state.indicatorTime!, timerIndicatorColor: state.indicatorColor!)
        
        animationLayerPercent.strokeColor = UIColor(named: state.overallIndicatorColorMain!)?.cgColor
        animationLayerFlickerIndex.strokeColor = UIColor(named: state.overallIndicatorColorMain!)?.cgColor
        lightQualityLabel.text = state.overallTitle
        lightQualityLabel.backgroundColor = UIColor(named: state.overallIndicatorColorSub!)
        helperLabel3.backgroundColor = lightQualityLabel.backgroundColor

        for i in state.sideeffects! {
            horizontalMoreInfoObjectsContainer.addArrangedSubview(i)
        }
    }
    
    
    func setDisplay(
        resultIcon: String, resultAnimationColor1: String, resultAnimationColor2: String,
        timerTime: String, timerIndication: Int, timerIndicatorColor: String) {
              
        let pulse1Color = UIColor(named: resultAnimationColor1)?.cgColor
        let pulse2Color = UIColor(named: resultAnimationColor2)?.cgColor
        
        let trackColor = UIColor(named: timerIndicatorColor)?.cgColor
        let timerScore = Double(timerIndication)

        //Top results image and animation
        overallResults.image = UIImage(named: resultIcon)
        overallResults.shake()
        let position = CGPoint(x: Constants.largeContainerDimension / 2, y: Constants.largeContainerDimension / 2)
        let pulse = PulseAnimation(numberOfPulses: 3, radius: Constants.largeContainerDimension * 1.15 / 2, position: position, color: pulse1Color!, duration: 1)
        let pulse2 = PulseAnimation(numberOfPulses: 2, radius: Constants.largeContainerDimension * 1.05 / 2, position: position, color: pulse2Color!, duration: 1)
        overallResultsHelper.layer.addSublayer(pulse)
        overallResultsHelper.layer.addSublayer(pulse2)
        
        //timer
        timerTitle.attributedText = attributedExposureText(text1: timerTime)
        timerFillerLayer.strokeColor = trackColor
        makeTimerGraphic(score: timerScore, track: timerTrackLayer, filler: timerFillerLayer)
    }
    
    
    func attributedText(text1: String, text2: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text1 + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: text2, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        return attributedText
    }
    
    func attributedExposureText(text1: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Exposure: ", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: text1, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        return attributedText
    }
    
    //when container views are tapped
    @objc func exposureTap(_ sender: UITapGestureRecognizer? = nil) {
        timerObjects = state.timerObject!
        timerSwiper.items = timerObjects
        popUpView.titleLabel.attributedText = popUpView.attributedTitle(text1: Constants.exposureTitle)
        presentMoreInfoPopUp(swiper: timerSwiper)
    }
    
    @objc func MoreInfoObjectTap(_ sender: UITapGestureRecognizer? = nil) {
        sideEffectsObjects = state.sideeffects!
        var helperArray = [MoreInfoObject]()
        for i in sideEffectsObjects {
            if (i.moreInfoImage != "Empty") {
                helperArray.append(i)
            }
        }
        MoreInfoObjectsSwiper.items = helperArray
        popUpView.titleLabel.attributedText = popUpView.attributedTitle(text1: Constants.sideEffectsTitle)
        presentMoreInfoPopUp(swiper: MoreInfoObjectsSwiper)
    }
    
    @objc func tipsTap(_ sender: UITapGestureRecognizer? = nil) {
        tipsSwiper.items = state.tipsObject!
        popUpView.titleLabel.attributedText = popUpView.attributedTitle(text1: Constants.tipsTitle)
        presentMoreInfoPopUp(swiper: tipsSwiper)
    }
    
    func presentMoreInfoPopUp(swiper: SwipingController) {
    
        self.view.addSubview(visualEffectView)
        self.view.addSubview(popUpView)
        popUpView.addSubview(swiper)

        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -(4 * Constants.topMargin)).isActive = true
        popUpView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -(2 * Constants.verticalMargins)).isActive = true
        
        swiper.topAnchor.constraint(equalTo: popUpView.closePopUpButton.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        swiper.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -Constants.verticalMargins * 2).isActive = true
        swiper.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor).isActive = true
        swiper.trailingAnchor.constraint(equalTo: popUpView.trailingAnchor).isActive = true
        
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
}

extension ResultsViewController: PopUpDelegate {
    
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpView.removeFromSuperview()
            self.timerSwiper.removeFromSuperview()
            self.tipsSwiper.removeFromSuperview()
            self.MoreInfoObjectsSwiper.removeFromSuperview()
        }
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1.25
        animation.values = [-1, 1, -1, 1, -1, 1, -1, 1, -1, 1, 0]
        self.layer.add(animation, forKey: "shake")
    }
}
 

