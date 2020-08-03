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
    var sideEffectsObjects = [MoreInfoObject]()
    var timerObjects = [MoreInfoObject]()
    var tipsObject = [MoreInfoObject]()
    var state = State(overallImageName: "", overallIndicatorColorMain: "", overallIndicatorColorSub: "", exposureTime: "", indicatorTime: 0, indicatorColor: "", sideeffects: [], timerObject: [], tipsObject: [])
    
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
    
    let infoContainerMoreInfoObjects: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColorAccentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    let horizontalMoreInfoObjectsContainer: UIStackView = {
        let container = UIStackView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.alignment = .center
        container.distribution = .fillEqually
        container.axis = .horizontal
        container.spacing = (Constants.containerDimension * 3 - 4 * Constants.smallContainerDimensions) / 5
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
    
    let MoreInfoObjectsTitle: UILabel = {
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
    
    let timerIndiatorContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*
    let timerIndicator: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        let size: CGFloat = 25.0
        animationLayer.frame = CGRect(x: 0, y: 0, width: size, height: size)
        animationLayer.cornerRadius = size / 2
        animationLayer.position = CGPoint(x: size / 2, y: Constants.smallContainerDimensions * 0.5)
        animationLayer.backgroundColor = UIColor.systemYellow.cgColor
        return animationLayer
    }()*/
    
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
        view.backgroundColor = UIColor(named: "mainColor")
        view.layer.cornerRadius = Constants.cornerRadius
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
        verticalContainer.addArrangedSubview(infoContainerMoreInfoObjects)
        verticalContainer.addArrangedSubview(tipsContainer)
        
        infoContainer.addSubview(timerTitle)
        infoContainer.addSubview(timerView)
        infoContainer.addSubview(timerIndiatorContainer)
        
        infoContainerMoreInfoObjects.addSubview(MoreInfoObjectsTitle)
        infoContainerMoreInfoObjects.addSubview(horizontalMoreInfoObjectsContainer)
        
        setupLayoutConstraints()

        timerIndiatorContainer.layer.addSublayer(timerTrackLayer)
        //timerIndiatorContainer.layer.addSublayer(timerIndicator)
        timerIndiatorContainer.layer.addSublayer(timerFillerLayer)

        setState()
        getNewResults()
        
        //Event handlers
        let exposureTap = UITapGestureRecognizer(target: self, action: #selector(exposureTap(_:)))
        infoContainer.addGestureRecognizer(exposureTap)
        let MoreInfoObjectTap = UITapGestureRecognizer(target: self, action: #selector(MoreInfoObjectTap(_:)))
        infoContainerMoreInfoObjects.addGestureRecognizer(MoreInfoObjectTap)
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
        
        infoContainerMoreInfoObjects.heightAnchor.constraint(equalToConstant: Constants.containerDimension * 1.3).isActive = true
        infoContainerMoreInfoObjects.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoContainerMoreInfoObjects.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 3).isActive = true
        
        // side effects title
        MoreInfoObjectsTitle.topAnchor.constraint(equalTo: infoContainerMoreInfoObjects.topAnchor, constant: Constants.sideMargins).isActive = true
        MoreInfoObjectsTitle.leadingAnchor.constraint(equalTo: infoContainerMoreInfoObjects.leadingAnchor, constant: Constants.sideMargins).isActive = true
        MoreInfoObjectsTitle.widthAnchor.constraint(equalTo: infoContainerMoreInfoObjects.widthAnchor).isActive = true
        
        //Side effects stack container
        horizontalMoreInfoObjectsContainer.topAnchor.constraint(equalTo: MoreInfoObjectsTitle.bottomAnchor).isActive = true
        horizontalMoreInfoObjectsContainer.leadingAnchor.constraint(equalTo: infoContainerMoreInfoObjects.leadingAnchor, constant: seperator).isActive = true
        horizontalMoreInfoObjectsContainer.trailingAnchor.constraint(equalTo: infoContainerMoreInfoObjects.trailingAnchor, constant: -seperator).isActive = true
        
        //tips container
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
    
    func makeTimerGraphic(score: Double, track: CAShapeLayer, filler: CAShapeLayer) {
        
        let endpoint = score / 100
        
        let path = UIBezierPath()
        let endOfPathX = Constants.containerDimension * 2
        path.move(to: CGPoint(x: 0 + Constants.sideMargins * 2, y: Constants.smallContainerDimensions * 0.5))
        path.addLine(to: CGPoint(x: endOfPathX , y: Constants.smallContainerDimensions * 0.5))

        track.path = path.cgPath
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
        
        /*
        let basicAnimation = CABasicAnimation(keyPath: "position")
        basicAnimation.toValue = CGPoint(x: endOfPathX * CGFloat(endpoint) + 12.5, y: Constants.smallContainerDimensions * 0.5)
        basicAnimation.duration = 2.0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animationLayer.add(basicAnimation, forKey: "position")*/
    }
    
    func setState() {
        setDisplay(resultIcon: state.overallImageName!, resultAnimationColor1: state.overallIndicatorColorMain!, resultAnimationColor2: state.overallIndicatorColorSub!, timerTime: state.exposureTime!, timerIndication: state.indicatorTime!, timerIndicatorColor: state.indicatorColor!)

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
        let position = CGPoint(x: Constants.largeContainerDimension / 2, y: Constants.largeContainerDimension / 2)
        let pulse = PulseAnimation(numberOfPulses: 3, radius: Constants.largeContainerDimension / 2, position: position, color: pulse1Color!, duration: 1)
        let pulse2 = PulseAnimation(numberOfPulses: 2, radius: Constants.largeContainerDimension / 1.8, position: position, color: pulse2Color!, duration: 1)
        overallResultsHelper.layer.addSublayer(pulse)
        overallResultsHelper.layer.addSublayer(pulse2)
        
        //timer
        timerTitle.attributedText = attributedExposureText(text1: timerTime)
        timerFillerLayer.strokeColor = trackColor
        //timerIndicator.backgroundColor = trackColor
        makeTimerGraphic(score: timerScore, track: timerTrackLayer, filler: timerFillerLayer)
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
        timerObjects = state.timerObject!
        timerSwiper.items = timerObjects
        popUpView.titleLabel.attributedText = popUpView.attributedTitle(text1: Constants.exposureTitle)
        presentMoreInfoPopUp(swiper: timerSwiper)
    }
    
    @objc func MoreInfoObjectTap(_ sender: UITapGestureRecognizer? = nil) {
        sideEffectsObjects = state.sideeffects!
        var helperArray = [MoreInfoObject]()
        for i in sideEffectsObjects {
            if (i.moreInfoImage != "") {
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
        
        swiper.topAnchor.constraint(equalTo: popUpView.closePopUpButton.bottomAnchor, constant: Constants.sideMargins).isActive = true
        swiper.bottomAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
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
            print("did remove")
        }
    }
}
