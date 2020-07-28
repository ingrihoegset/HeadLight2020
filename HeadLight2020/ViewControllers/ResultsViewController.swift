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
        animationLayer.frame = CGRect(x: Constants.sideMargins * 2, y: 0, width: 25, height: 25)
        animationLayer.cornerRadius = 12.5
        animationLayer.position = CGPoint(x: 0, y: Constants.smallContainerDimensions * 0.5)
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
    
    let popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.layer.cornerRadius = Constants.cornerRadius
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
        makeTimerGraphic(score: 50.0, track: timerTrackLayer, animationLayer: timerIndicator, filler: timerFillerLayer)

        worstLight()
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
        scrollView.topAnchor.constraint(equalTo: flickerIndexTitle.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //Vertical Container
        verticalContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        verticalContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        verticalContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        verticalContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        verticalContainer.heightAnchor.constraint(equalToConstant: 700).isActive = true
        verticalContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        // info container timer
        infoContainer.topAnchor.constraint(equalTo: verticalContainer.topAnchor, constant: Constants.verticalMargins).isActive = true
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
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0 + Constants.sideMargins * 2, y: Constants.smallContainerDimensions * 0.5))
        path.addLine(to: CGPoint(x: Constants.containerDimension * 2 , y: Constants.smallContainerDimensions * 0.5))

        track.path = path.cgPath
        filler.path = path.cgPath
        
        let barAnimation = CABasicAnimation(keyPath: "strokeEnd")
        barAnimation.toValue = score / 100
        barAnimation.duration = 2.0
        barAnimation.fillMode = CAMediaTimingFillMode.forwards
        barAnimation.isRemovedOnCompletion = false
        filler.add(barAnimation, forKey: "basic")
        
        
        let basicAnimation = CABasicAnimation(keyPath: "position")
        basicAnimation.toValue = CGPoint(x: Constants.containerDimension, y: Constants.smallContainerDimensions * 0.5)
        basicAnimation.duration = 2.0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animationLayer.add(basicAnimation, forKey: "position")
    }
    
    func worstLight() {
        //Top image
        let position = CGPoint(x: Constants.largeContainerDimension / 2, y: Constants.largeContainerDimension / 2)
        let pulse = PulseAnimation(numberOfPulses: 3, radius: Constants.largeContainerDimension / 2, position: position, color: UIColor.red.cgColor, duration: 1)
        let pulse2 = PulseAnimation(numberOfPulses: 2, radius: Constants.largeContainerDimension / 1.8, position: position, color: UIColor.red.cgColor, duration: 1)
        overallResultsHelper.layer.addSublayer(pulse)
        overallResultsHelper.layer.addSublayer(pulse2)
        overallResults.image = UIImage(named: "Worst")
        
        //Recommended exposure time
        timerTitle.attributedText = attributedExposureText(text1: "30 min")
        
        //Side effect containers
        sideEffectContainer1.image = UIImage(named: "EyeStrain")
        sideEffectsTitle1.attributedText = attributedText(text1: "Eye", text2: "Strain")
        sideEffectContainer2.image = UIImage(named: "Dizzyness")
        sideEffectsTitle2.attributedText = attributedText(text1: "Dizzyness", text2: "")
        sideEffectContainer3.image = UIImage(named: "Headache")
        sideEffectsTitle3.attributedText = attributedText(text1: "Headache", text2: "")
            sideEffectContainer4.image = UIImage(named: "Discomfort")
        sideEffectsTitle4.attributedText = attributedText(text1: "General", text2: "Discomfort")
    }
    
    func secondWorstLight() {
        //Top image
        overallResults.image = UIImage(named: "SecondWorst")
        
        //Recommended exposure time
        
        //Side effect containers
        sideEffectContainer1.image = UIImage(named: "EyeStrain")
        sideEffectsTitle1.attributedText = attributedText(text1: "Eye", text2: "Strain")
        sideEffectContainer2.image = UIImage(named: "Dizzyness")
        sideEffectsTitle2.attributedText = attributedText(text1: "Dizzyness", text2: "")
        sideEffectContainer3.image = UIImage(named: "Headache")
        sideEffectsTitle3.attributedText = attributedText(text1: "Headache", text2: "")
            sideEffectContainer4.image = UIImage(named: "Discomfort")
        sideEffectsTitle4.attributedText = attributedText(text1: "General", text2: "Discomfort")
    }
    
    func OKLight() {
        //Top image
        overallResults.image = UIImage(named: "OK")
        
        //Recommended exposure time
        
        //Side effect containers
        sideEffectContainer1.image = UIImage(named: "EyeStrain")
        sideEffectsTitle1.attributedText = attributedText(text1: "Eye", text2: "Strain")
        sideEffectContainer2.image = UIImage(named: "Dizzyness")
        sideEffectsTitle2.attributedText = attributedText(text1: "Dizzyness", text2: "")
        sideEffectContainer3.image = UIImage(named: "Headache")
        sideEffectsTitle3.attributedText = attributedText(text1: "Headache", text2: "")
            sideEffectContainer4.image = UIImage(named: "Discomfort")
        sideEffectsTitle4.attributedText = attributedText(text1: "General", text2: "Discomfort")
    }
    

    
    func bestLight() {
        //Top image
        overallResults.image = UIImage(named: "Best")
        
        //Recommended exposure time
        
        //Side effect containers
        sideEffectContainer1.image = UIImage(named: "EyeStrain")
        sideEffectsTitle1.attributedText = attributedText(text1: "Eye", text2: "Strain")
        sideEffectContainer2.image = UIImage(named: "Dizzyness")
        sideEffectsTitle2.attributedText = attributedText(text1: "Dizzyness", text2: "")
        sideEffectContainer3.image = UIImage(named: "Headache")
        sideEffectsTitle3.attributedText = attributedText(text1: "Headache", text2: "")
            sideEffectContainer4.image = UIImage(named: "Discomfort")
        sideEffectsTitle4.attributedText = attributedText(text1: "General", text2: "Discomfort")
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
        overallResults.backgroundColor = .green
        presentMoreInfoPopUp()
    }
    
    @objc func sideeffectTap(_ sender: UITapGestureRecognizer? = nil) {
        overallResults.backgroundColor = .systemYellow
    }
    
    @objc func tipsTap(_ sender: UITapGestureRecognizer? = nil) {
        overallResults.backgroundColor = .systemPink
    }
    
    func presentMoreInfoPopUp() {
        self.view.addSubview(popUpView)
        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -(2 * Constants.topMargin)).isActive = true
        popUpView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -(2 * Constants.verticalMargins)).isActive = true
        
    }

}
