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
    let okColor = UIColor.systemYellow.cgColor

    
    let overallResults: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = Constants.largeContainerDimension * 0.8 / 2
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
    
    let percentResultsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let flickerIndexResultsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hertzResultsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailCircle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = Constants.radius
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
         label.textColor = UIColor(named: "mainColorAccentDark")
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
    
    let flickerPercentTitle: UILabel = {
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
    
    let flickerIndexTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Flicker"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Index", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let hertzTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Hertz"
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 16)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        label.attributedText = attributedText
        return label
    }()
    
    //Underlying track for animation flicker percent
    let trackLayerPercent: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(named: "mainColorAccentLight")?.cgColor
        trackLayer.lineWidth = 8
        trackLayer.lineCap = .round
        return trackLayer
    }()
    
    let animationLayerPercent: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.lineWidth = 8
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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let verticalContainer: UIStackView = {
        let container = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.alignment = .center
        container.distribution = .fillProportionally
        container.spacing = Constants.verticalMargins
        return container
    }()
    
    let infoContainer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    let infoContainerSideEffects: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        return view
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
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        let image = UIImage(named: "Timer")
        view.image = image
        return view
    }()
    
    let sideEffectsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Possible Side Effects"
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Italic", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        label.attributedText = attributedText
        return label
    }()
    
    let sideEffectsTitle1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "nan"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: "nan", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let sideEffectContainer1: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        return view
    }()
    
    let sideEffectsTitle2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "nan"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: "nan", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let sideEffectContainer2: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        return view
    }()
    
    let sideEffectsTitle3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "nan"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: "nan", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let sideEffectContainer3: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        return view
    }()
    
    let sideEffectsTitle4: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "nan"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: "nan", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        label.attributedText = attributedText
        return label
    }()
    
    let sideEffectContainer4: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        return view
    }()
    
    let timerIndiatorContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timerIndicator: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        let size: CGFloat = 25.0
        animationLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        animationLayer.cornerRadius = size / 2
        animationLayer.position = CGPoint(x: size / 2, y: Constants.smallContainerDimensions * 0.5)
        animationLayer.backgroundColor = UIColor.systemYellow.cgColor
        return animationLayer
    }()
    
    let timerTrackLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 8
        layer.lineCap = .round
        layer.strokeColor = UIColor(named: "mainColorVeryTinted")?.cgColor
        return layer
    }()
    
    let timerFillerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.red.cgColor
        layer.lineWidth = 8
        layer.strokeEnd = 0
        layer.lineCap = .round
        layer.strokeColor = UIColor.systemYellow.cgColor
        return layer
    }()
    
    let tipsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.layer.cornerRadius = Constants.cornerRadius
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        let text = "Tips...."
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Italic", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        label.attributedText = attributedText
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.sideMargins).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargins).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        return view
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView(frame: .zero, title: "Title")
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = Constants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    let swiper: SwipingController = {
        let swiper = SwipingController(frame: .zero)
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "mainColor")
        self.view.addSubview(overallResultsHelper)
        self.view.addSubview(overallResults)

        self.view.addSubview(percentResultsContainer)
        percentResultsContainer.addSubview(resultsViewPercent)
        percentResultsContainer.layer.addSublayer(trackLayerPercent)
        percentResultsContainer.layer.addSublayer(animationLayerPercent)
        makeGraphic(score: flickerPercent, trackLayer: trackLayerPercent, animationLayer: animationLayerPercent, duration: 2.5)
        self.view.addSubview(flickerPercentTitle)
        
        self.view.addSubview(flickerIndexResultsContainer)
        flickerIndexResultsContainer.addSubview(resultsViewFlickerIndex)
        flickerIndexResultsContainer.layer.addSublayer(trackLayerFlickerIndex)
        flickerIndexResultsContainer.layer.addSublayer(animationLayerFlickerIndex)
        makeGraphic(score: flickerIndex, trackLayer: trackLayerFlickerIndex, animationLayer: animationLayerFlickerIndex, duration: 1.5)
        self.view.addSubview(flickerIndexTitle)
        
        self.view.addSubview(hertzResultsContainer)
        hertzResultsContainer.addSubview(detailCircle)
        detailCircle.addSubview(resultsViewHertz)
        self.view.addSubview(hertzTitle)
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(verticalContainer)
        verticalContainer.addArrangedSubview(infoContainer)
        verticalContainer.addArrangedSubview(infoContainerSideEffects)
        verticalContainer.addArrangedSubview(tipsContainer)
        
        infoContainer.addSubview(timerTitle)
        infoContainer.addSubview(timerView)
        infoContainer.addSubview(timerIndiatorContainer)
        
        infoContainerSideEffects.addSubview(sideEffectsTitle)
        infoContainerSideEffects.addSubview(sideEffectContainer1)
        infoContainerSideEffects.addSubview(sideEffectsTitle1)
        infoContainerSideEffects.addSubview(sideEffectContainer2)
        infoContainerSideEffects.addSubview(sideEffectsTitle2)
        infoContainerSideEffects.addSubview(sideEffectContainer3)
        infoContainerSideEffects.addSubview(sideEffectsTitle3)
        infoContainerSideEffects.addSubview(sideEffectContainer4)
        infoContainerSideEffects.addSubview(sideEffectsTitle4)
        
        setupLayoutConstraints()

        timerIndiatorContainer.layer.addSublayer(timerTrackLayer)
        timerIndiatorContainer.layer.addSublayer(timerIndicator)
        timerIndiatorContainer.layer.addSublayer(timerFillerLayer)


        setState(state: "stateSecondWorst")
        getNewResults()
        
        //Event handlers
        let exposureTap = UITapGestureRecognizer(target: self, action: #selector(exposureTap(_:)))
        infoContainer.addGestureRecognizer(exposureTap)
        let sideeffectTap = UITapGestureRecognizer(target: self, action: #selector(sideeffectTap(_:)))
        infoContainerSideEffects.addGestureRecognizer(sideeffectTap)
        let tipsTap = UITapGestureRecognizer(target: self, action: #selector(tipsTap(_:)))
        tipsContainer.addGestureRecognizer(tipsTap)
        
    }

    private func setupLayoutConstraints() {
        // overall results display
        overallResults.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topMargin * 0.6).isActive = true
        overallResults.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overallResults.heightAnchor.constraint(equalToConstant: Constants.largeContainerDimension * 0.8).isActive = true
        overallResults.widthAnchor.constraint(equalToConstant: Constants.largeContainerDimension * 0.8).isActive = true
        
        // overall results helper - purpose to create lalyer between animation
        overallResultsHelper.centerYAnchor.constraint(equalTo: overallResults.centerYAnchor).isActive = true
        overallResultsHelper.centerXAnchor.constraint(equalTo: overallResults.centerXAnchor).isActive = true
        overallResultsHelper.heightAnchor.constraint(equalToConstant: Constants.largeContainerDimension).isActive = true
        overallResultsHelper.widthAnchor.constraint(equalToConstant: Constants.largeContainerDimension).isActive = true
        
        // flicker index results container
        flickerIndexResultsContainer.topAnchor.constraint(equalTo: overallResultsHelper.bottomAnchor).isActive = true
        flickerIndexResultsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flickerIndexResultsContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        flickerIndexResultsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // flicker index results display
        resultsViewFlickerIndex.centerXAnchor.constraint(equalTo: flickerIndexResultsContainer.centerXAnchor).isActive = true
        resultsViewFlickerIndex.centerYAnchor.constraint(equalTo: flickerIndexResultsContainer.centerYAnchor).isActive = true
        resultsViewFlickerIndex.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        resultsViewFlickerIndex.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // flicker index title label
        flickerIndexTitle.centerXAnchor.constraint(equalTo: flickerIndexResultsContainer.centerXAnchor).isActive = true
        flickerIndexTitle.topAnchor.constraint(equalTo: flickerIndexResultsContainer.bottomAnchor, constant: -Constants.verticalMargins * 0.5).isActive = true
        flickerIndexTitle.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // percent results container
        percentResultsContainer.topAnchor.constraint(equalTo: overallResultsHelper.bottomAnchor).isActive = true
        percentResultsContainer.trailingAnchor.constraint(equalTo: flickerIndexResultsContainer.leadingAnchor).isActive = true
        percentResultsContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        percentResultsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // percent results display
        resultsViewPercent.centerYAnchor.constraint(equalTo: percentResultsContainer.centerYAnchor).isActive = true
        resultsViewPercent.centerXAnchor.constraint(equalTo: percentResultsContainer.centerXAnchor).isActive = true
        resultsViewPercent.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        resultsViewPercent.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // percent title label
        flickerPercentTitle.centerXAnchor.constraint(equalTo: percentResultsContainer.centerXAnchor).isActive = true
        flickerPercentTitle.topAnchor.constraint(equalTo: percentResultsContainer.bottomAnchor, constant: -Constants.verticalMargins * 0.5).isActive = true
        flickerPercentTitle.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // hertz results container
        hertzResultsContainer.topAnchor.constraint(equalTo: overallResultsHelper.bottomAnchor).isActive = true
        hertzResultsContainer.leadingAnchor.constraint(equalTo: flickerIndexResultsContainer.trailingAnchor).isActive = true
        hertzResultsContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        hertzResultsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // hertz results display
        detailCircle.centerYAnchor.constraint(equalTo: hertzResultsContainer.centerYAnchor).isActive = true
        detailCircle.centerXAnchor.constraint(equalTo: hertzResultsContainer.centerXAnchor).isActive = true
        detailCircle.heightAnchor.constraint(equalToConstant: Constants.radius * 2).isActive = true
        detailCircle.widthAnchor.constraint(equalToConstant: Constants.radius * 2).isActive = true
        
        // hertz results display
        resultsViewHertz.centerYAnchor.constraint(equalTo: detailCircle.centerYAnchor).isActive = true
        resultsViewHertz.centerXAnchor.constraint(equalTo: detailCircle.centerXAnchor).isActive = true
        resultsViewHertz.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        resultsViewHertz.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // hertz title label
        hertzTitle.centerXAnchor.constraint(equalTo: hertzResultsContainer.centerXAnchor).isActive = true
        hertzTitle.topAnchor.constraint(equalTo: hertzResultsContainer.bottomAnchor, constant: -Constants.verticalMargins * 0.5).isActive = true
        hertzTitle.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        let seperator = ((Constants.containerDimension * 3) - (4 * Constants.smallContainerDimensions)) / 5
        
        //ScrollView
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: flickerIndexTitle.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //Vertical Container
        verticalContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        verticalContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        verticalContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        verticalContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        verticalContainer.heightAnchor.constraint(equalToConstant: 700).isActive = true
        verticalContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        // info container timer
        infoContainer.topAnchor.constraint(equalTo: verticalContainer.topAnchor).isActive = true
        infoContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        infoContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
        infoContainer.centerXAnchor.constraint(equalTo: verticalContainer.centerXAnchor).isActive = true
        
        // timer title
        timerTitle.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: Constants.sideMargins).isActive = true
        timerTitle.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: Constants.sideMargins).isActive = true
        timerTitle.widthAnchor.constraint(equalTo: infoContainer.widthAnchor).isActive = true
        
        // timer image container
        timerView.topAnchor.constraint(equalTo: timerTitle.bottomAnchor).isActive = true
        timerView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: seperator).isActive = true
        timerView.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        timerView.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // timer indicator container
        timerIndiatorContainer.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        timerIndiatorContainer.leadingAnchor.constraint(equalTo: timerView.trailingAnchor).isActive = true
        timerIndiatorContainer.topAnchor.constraint(equalTo: timerTitle.bottomAnchor).isActive = true
        timerIndiatorContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        // info container side effects
        infoContainerSideEffects.heightAnchor.constraint(equalToConstant: Constants.containerDimension * 1.3).isActive = true
        infoContainerSideEffects.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoContainerSideEffects.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
        
        // side effects title
        sideEffectsTitle.topAnchor.constraint(equalTo: infoContainerSideEffects.topAnchor, constant: Constants.sideMargins).isActive = true
        sideEffectsTitle.leadingAnchor.constraint(equalTo: infoContainerSideEffects.leadingAnchor, constant: Constants.sideMargins).isActive = true
        sideEffectsTitle.widthAnchor.constraint(equalTo: infoContainerSideEffects.widthAnchor).isActive = true
        
        // side effect container 1
        sideEffectContainer1.topAnchor.constraint(equalTo: sideEffectsTitle.bottomAnchor).isActive = true
        sideEffectContainer1.leadingAnchor.constraint(equalTo: infoContainerSideEffects.leadingAnchor, constant: seperator).isActive = true
        sideEffectContainer1.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        sideEffectContainer1.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // side effects title 1
        sideEffectsTitle1.topAnchor.constraint(equalTo: sideEffectContainer1.bottomAnchor).isActive = true
        sideEffectsTitle1.centerXAnchor.constraint(equalTo: sideEffectContainer1.centerXAnchor).isActive = true
        sideEffectsTitle1.widthAnchor.constraint(equalTo: sideEffectContainer1.widthAnchor).isActive = true
        
        // side effect container 2
        sideEffectContainer2.topAnchor.constraint(equalTo: sideEffectsTitle.bottomAnchor).isActive = true
        sideEffectContainer2.leadingAnchor.constraint(equalTo: sideEffectContainer1.trailingAnchor, constant: seperator).isActive = true
        sideEffectContainer2.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        sideEffectContainer2.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // side effects title 2
        sideEffectsTitle2.topAnchor.constraint(equalTo: sideEffectContainer2.bottomAnchor).isActive = true
        sideEffectsTitle2.centerXAnchor.constraint(equalTo: sideEffectContainer2.centerXAnchor).isActive = true
        sideEffectsTitle2.widthAnchor.constraint(equalTo: sideEffectContainer2.widthAnchor).isActive = true
        
        // side effect container 3
        sideEffectContainer3.topAnchor.constraint(equalTo: sideEffectsTitle.bottomAnchor).isActive = true
        sideEffectContainer3.leadingAnchor.constraint(equalTo: sideEffectContainer2.trailingAnchor, constant: seperator).isActive = true
        sideEffectContainer3.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        sideEffectContainer3.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // side effects title 3
        sideEffectsTitle3.topAnchor.constraint(equalTo: sideEffectContainer3.bottomAnchor).isActive = true
        sideEffectsTitle3.centerXAnchor.constraint(equalTo: sideEffectContainer3.centerXAnchor).isActive = true
        sideEffectsTitle3.widthAnchor.constraint(equalTo: sideEffectContainer3.widthAnchor).isActive = true
        
        // side effect container 4
        sideEffectContainer4.topAnchor.constraint(equalTo: sideEffectsTitle.bottomAnchor).isActive = true
        sideEffectContainer4.leadingAnchor.constraint(equalTo: sideEffectContainer3.trailingAnchor, constant: seperator).isActive = true
        sideEffectContainer4.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        sideEffectContainer4.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // side effects title 4
        sideEffectsTitle4.topAnchor.constraint(equalTo: sideEffectContainer4.bottomAnchor).isActive = true
        sideEffectsTitle4.centerXAnchor.constraint(equalTo: sideEffectContainer4.centerXAnchor).isActive = true
        sideEffectsTitle4.widthAnchor.constraint(equalTo: sideEffectContainer4.widthAnchor).isActive = true
        
        // info container side effects
        tipsContainer.heightAnchor.constraint(equalToConstant: Constants.containerDimension * 2).isActive = true
        tipsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tipsContainer.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
    }
    
    func getNewResults() {

        let flickerPercentText = String(format: "%.0f", flickerPercent)
        let flickerPercentAttributedText = NSMutableAttributedString(string: flickerPercentText + " %", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        resultsViewPercent.attributedText = flickerPercentAttributedText
        
        let flickerIndexText = String(format: "%.0f", flickerIndex)
        let flickerIndexAttributedText = NSMutableAttributedString(string: flickerIndexText, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        resultsViewFlickerIndex.attributedText = flickerIndexAttributedText
        
        let hertzText = String(format: "%.0f", hertz)
        let hertzAttributedText = NSMutableAttributedString(string: hertzText, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        resultsViewHertz.attributedText = hertzAttributedText
    }
    
    func makeGraphic(score: Double, trackLayer: CAShapeLayer, animationLayer: CAShapeLayer, duration: Double) {


        //Location for track and for animation
        let center = CGPoint(x: Constants.containerDimension * 0.5, y: Constants.containerDimension * 0.5)

        //Path for animation and underlying path
        let circularPath = UIBezierPath(arcCenter: center, radius: CGFloat(Constants.radius), startAngle: (3 * CGFloat.pi) / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        animationLayer.path = circularPath.cgPath

        let scale = CGFloat(score / 100.0)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = scale
        basicAnimation.duration = duration
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animationLayer.add(basicAnimation, forKey: "basic")
    }
    
    func makeTimerGraphic(score: Double, track: CAShapeLayer, animationLayer: CAShapeLayer, filler: CAShapeLayer) {
        
        let endpoint = score / 100
        
        let path = UIBezierPath()
        let endOfPathX = Constants.containerDimension * 2
        path.move(to: CGPoint(x: 0 + Constants.sideMargins * 2, y: Constants.smallContainerDimensions * 0.5))
        path.addLine(to: CGPoint(x: endOfPathX , y: Constants.smallContainerDimensions * 0.5))

        track.path = path.cgPath
        filler.path = path.cgPath
        
        let barAnimation = CABasicAnimation(keyPath: "strokeEnd")
        barAnimation.toValue = endpoint
        barAnimation.duration = 2.0
        barAnimation.fillMode = CAMediaTimingFillMode.forwards
        barAnimation.isRemovedOnCompletion = false
        filler.add(barAnimation, forKey: "basic")
        
        let basicAnimation = CABasicAnimation(keyPath: "position")
        basicAnimation.toValue = CGPoint(x: endOfPathX * CGFloat(endpoint) + 12.5, y: Constants.smallContainerDimensions * 0.5)
        basicAnimation.duration = 2.0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animationLayer.add(basicAnimation, forKey: "position")
    }
    
    func setState(state: String) {
        if (state == "stateBest") {
            setDisplay(resultIcon: Constants.stateBest[0],
                resultAnimationColor1: Constants.stateBest[1], resultAnimationColor2: Constants.stateBest[2],
                timerTime: Constants.stateBest[3], timerIndication: Constants.stateBest[4], timerIndicatorColor: Constants.stateBest[5],
                sideEffectsBackgroundColor1: Constants.stateBest[6],
                sideEffect1Image: Constants.stateBest[7], sideEffect1Text1: Constants.stateBest[8], sideEffect1Text2: Constants.stateBest[9],
                sideEffectsBackgroundColor2: Constants.stateBest[10],
                sideEffect2Image: Constants.stateBest[11], sideEffect2Text1: Constants.stateBest[12], sideEffect2Text2: Constants.stateBest[13],
                sideEffectsBackgroundColor3: Constants.stateBest[14],
                sideEffect3Image: Constants.stateBest[15], sideEffect3Text1: Constants.stateBest[16], sideEffect3Text2: Constants.stateBest[17],
                sideEffectsBackgroundColor4: Constants.stateBest[18],
                sideEffect4Image: Constants.stateBest[19], sideEffect4Text1: Constants.stateBest[20], sideEffect4Text2: Constants.stateBest[21])
        }
        
        if (state == "stateSecondBest") {
            setDisplay(resultIcon: Constants.stateSecondBest[0],
                resultAnimationColor1: Constants.stateSecondBest[1], resultAnimationColor2: Constants.stateSecondBest[2],
                timerTime: Constants.stateSecondBest[3], timerIndication: Constants.stateSecondBest[4], timerIndicatorColor: Constants.stateSecondBest[5],
                sideEffectsBackgroundColor1: Constants.stateSecondBest[6],
                sideEffect1Image: Constants.stateSecondBest[7], sideEffect1Text1: Constants.stateSecondBest[8], sideEffect1Text2: Constants.stateSecondBest[9],
                sideEffectsBackgroundColor2: Constants.stateSecondBest[10],
                sideEffect2Image: Constants.stateSecondBest[11], sideEffect2Text1: Constants.stateSecondBest[12], sideEffect2Text2: Constants.stateSecondBest[13],
                sideEffectsBackgroundColor3: Constants.stateSecondBest[14],
                sideEffect3Image: Constants.stateSecondBest[15], sideEffect3Text1: Constants.stateSecondBest[16], sideEffect3Text2: Constants.stateSecondBest[17],
                sideEffectsBackgroundColor4: Constants.stateSecondBest[18],
                sideEffect4Image: Constants.stateSecondBest[19], sideEffect4Text1: Constants.stateSecondBest[20], sideEffect4Text2: Constants.stateBest[21])
        }
            
        else if (state == "stateSecondBest") {
            setDisplay(resultIcon: Constants.stateSecondBest[0],
                resultAnimationColor1: Constants.stateSecondBest[1], resultAnimationColor2: Constants.stateSecondBest[2],
                timerTime: Constants.stateSecondBest[3], timerIndication: Constants.stateSecondBest[4], timerIndicatorColor: Constants.stateSecondBest[5],
                sideEffectsBackgroundColor1: Constants.stateSecondBest[6],
                sideEffect1Image: Constants.stateSecondBest[7], sideEffect1Text1: Constants.stateSecondBest[8], sideEffect1Text2: Constants.stateSecondBest[9],
                sideEffectsBackgroundColor2: Constants.stateSecondBest[10],
                sideEffect2Image: Constants.stateSecondBest[11], sideEffect2Text1: Constants.stateSecondBest[12], sideEffect2Text2: Constants.stateSecondBest[13],
                sideEffectsBackgroundColor3: Constants.stateSecondBest[14],
                sideEffect3Image: Constants.stateSecondBest[15], sideEffect3Text1: Constants.stateSecondBest[16], sideEffect3Text2: Constants.stateSecondBest[17],
                sideEffectsBackgroundColor4: Constants.stateSecondBest[18],
                sideEffect4Image: Constants.stateSecondBest[19], sideEffect4Text1: Constants.stateSecondBest[20], sideEffect4Text2: Constants.stateBest[21])
            }
        else if (state == "stateSecondWorst") {
            setDisplay(resultIcon: Constants.stateSecondWorst[0],
                resultAnimationColor1: Constants.stateSecondWorst[1], resultAnimationColor2: Constants.stateSecondWorst[2],
                timerTime: Constants.stateSecondWorst[3], timerIndication: Constants.stateSecondWorst[4], timerIndicatorColor: Constants.stateSecondWorst[5],
                sideEffectsBackgroundColor1: Constants.stateSecondWorst[6],
                sideEffect1Image: Constants.stateSecondWorst[7], sideEffect1Text1: Constants.stateSecondWorst[8], sideEffect1Text2: Constants.stateSecondWorst[9],
                sideEffectsBackgroundColor2: Constants.stateSecondWorst[10],
                sideEffect2Image: Constants.stateSecondWorst[11], sideEffect2Text1: Constants.stateSecondWorst[12], sideEffect2Text2: Constants.stateSecondWorst[13],
                sideEffectsBackgroundColor3: Constants.stateSecondWorst[14],
                sideEffect3Image: Constants.stateSecondWorst[15], sideEffect3Text1: Constants.stateSecondWorst[16], sideEffect3Text2: Constants.stateSecondWorst[17],
                sideEffectsBackgroundColor4: Constants.stateSecondWorst[18],
                sideEffect4Image: Constants.stateSecondWorst[19], sideEffect4Text1: Constants.stateSecondWorst[20], sideEffect4Text2: Constants.stateBest[21])
        }
            
            
        else if (state == "stateWorst") {
            setDisplay(resultIcon: Constants.stateWorst[0],
                resultAnimationColor1: Constants.stateWorst[1], resultAnimationColor2: Constants.stateWorst[2],
                timerTime: Constants.stateWorst[3], timerIndication: Constants.stateWorst[4], timerIndicatorColor: Constants.stateWorst[5],
                sideEffectsBackgroundColor1: Constants.stateWorst[6],
                sideEffect1Image: Constants.stateWorst[7], sideEffect1Text1: Constants.stateWorst[8], sideEffect1Text2: Constants.stateWorst[9],
                sideEffectsBackgroundColor2: Constants.stateWorst[10],
                sideEffect2Image: Constants.stateWorst[11], sideEffect2Text1: Constants.stateWorst[12], sideEffect2Text2: Constants.stateWorst[13],
                sideEffectsBackgroundColor3: Constants.stateWorst[14],
                sideEffect3Image: Constants.stateWorst[15], sideEffect3Text1: Constants.stateWorst[16], sideEffect3Text2: Constants.stateWorst[17],
                sideEffectsBackgroundColor4: Constants.stateWorst[18],
                sideEffect4Image: Constants.stateWorst[19], sideEffect4Text1: Constants.stateWorst[20], sideEffect4Text2: Constants.stateWorst[21])
        }
        else if (state == "stateOK") {
            setDisplay(resultIcon: Constants.stateOK[0],
                resultAnimationColor1: Constants.stateOK[1], resultAnimationColor2: Constants.stateOK[2],
                timerTime: Constants.stateOK[3], timerIndication: Constants.stateOK[4], timerIndicatorColor: Constants.stateOK[5],
                sideEffectsBackgroundColor1: Constants.stateOK[6],
                sideEffect1Image: Constants.stateOK[7], sideEffect1Text1: Constants.stateOK[8], sideEffect1Text2: Constants.stateOK[9],
                sideEffectsBackgroundColor2: Constants.stateOK[10],
                sideEffect2Image: Constants.stateOK[11], sideEffect2Text1: Constants.stateOK[12], sideEffect2Text2: Constants.stateOK[13],
                sideEffectsBackgroundColor3: Constants.stateOK[14],
                sideEffect3Image: Constants.stateOK[15], sideEffect3Text1: Constants.stateOK[16], sideEffect3Text2: Constants.stateOK[17],
                sideEffectsBackgroundColor4: Constants.stateOK[18],
                sideEffect4Image: Constants.stateOK[19], sideEffect4Text1: Constants.stateOK[20], sideEffect4Text2: Constants.stateOK[21])
        }
        

        
    }
    
    
    func setDisplay(
        resultIcon: String, resultAnimationColor1: String, resultAnimationColor2: String,
        timerTime: String, timerIndication: String, timerIndicatorColor: String,
        sideEffectsBackgroundColor1: String,
        sideEffect1Image: String, sideEffect1Text1: String, sideEffect1Text2: String,
        sideEffectsBackgroundColor2: String,
        sideEffect2Image: String, sideEffect2Text1: String, sideEffect2Text2: String,
        sideEffectsBackgroundColor3: String,
        sideEffect3Image: String, sideEffect3Text1: String, sideEffect3Text2: String,
        sideEffectsBackgroundColor4: String,
        sideEffect4Image: String, sideEffect4Text1: String, sideEffect4Text2: String) {
              
        let pulse1Color = UIColor(named: resultAnimationColor1)?.cgColor
        let pulse2Color = UIColor(named: resultAnimationColor2)?.cgColor
        let trackColor = UIColor(named: timerIndicatorColor)?.cgColor
        let timerScore = Double(timerIndication)
        let sideEffectsBGC1 = UIColor(named: sideEffectsBackgroundColor1)
        let sideEffectsBGC2 = UIColor(named: sideEffectsBackgroundColor2)
        let sideEffectsBGC3 = UIColor(named: sideEffectsBackgroundColor3)
        let sideEffectsBGC4 = UIColor(named: sideEffectsBackgroundColor4)
        
        //Top results image and animation
        overallResults.image = UIImage(named: resultIcon)
        let position = CGPoint(x: Constants.largeContainerDimension / 2, y: Constants.largeContainerDimension / 2)
        let pulse = PulseAnimation(numberOfPulses: 3, radius: Constants.largeContainerDimension / 2, position: position, color: pulse1Color!, duration: 1)
        let pulse2 = PulseAnimation(numberOfPulses: 2, radius: Constants.largeContainerDimension / 1.8, position: position, color: pulse2Color!, duration: 1)
        overallResultsHelper.layer.addSublayer(pulse)
        overallResultsHelper.layer.addSublayer(pulse2)
        
        //timer
        timerTitle.attributedText = attributedExposureText(text1: timerTime)
        timerFillerLayer.strokeColor = trackColor
        timerIndicator.backgroundColor = trackColor
        makeTimerGraphic(score: timerScore!, track: timerTrackLayer, animationLayer: timerIndicator, filler: timerFillerLayer)
        
        //Side effect containers
        sideEffectContainer1.image = UIImage(named: sideEffect1Image)
        sideEffectContainer1.backgroundColor = sideEffectsBGC1
        sideEffectsTitle1.attributedText = attributedText(text1: sideEffect1Text1, text2: sideEffect1Text2)
        
        sideEffectContainer2.image = UIImage(named: sideEffect2Image)
        sideEffectContainer2.backgroundColor = sideEffectsBGC2
        sideEffectsTitle2.attributedText = attributedText(text1: sideEffect2Text1, text2: sideEffect2Text2)
        
        sideEffectContainer3.image = UIImage(named: sideEffect3Image)
        sideEffectContainer3.backgroundColor = sideEffectsBGC3
        sideEffectsTitle3.attributedText = attributedText(text1: sideEffect3Text1, text2: sideEffect3Text2)
        
        sideEffectContainer4.image = UIImage(named: sideEffect4Image)
        sideEffectContainer4.backgroundColor = sideEffectsBGC4
        sideEffectsTitle4.attributedText = attributedText(text1: sideEffect4Text1, text2: sideEffect4Text2)
    }
    
    
    func attributedText(text1: String, text2: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text1 + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: text2, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        return attributedText
    }
    
    func attributedExposureText(text1: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Exposure: ", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Italic", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: text1, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        return attributedText
    }
    
    //when container views are tapped
    @objc func exposureTap(_ sender: UITapGestureRecognizer? = nil) {
        presentMoreInfoPopUp()
    }
    
    @objc func sideeffectTap(_ sender: UITapGestureRecognizer? = nil) {
        presentMoreInfoPopUp()
    }
    
    @objc func tipsTap(_ sender: UITapGestureRecognizer? = nil) {
        presentMoreInfoPopUp()
    }
    
    func presentMoreInfoPopUp() {
        
        self.view.addSubview(visualEffectView)
        self.view.addSubview(popUpView)
        popUpView.addSubview(swiper)

        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -(4 * Constants.topMargin)).isActive = true
        popUpView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -(2 * Constants.verticalMargins)).isActive = true
        
        swiper.topAnchor.constraint(equalTo: popUpView.closePopUpButton.bottomAnchor).isActive = true
        swiper.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor).isActive = true
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
            print("did remove")
        }
    }
    
    
}
