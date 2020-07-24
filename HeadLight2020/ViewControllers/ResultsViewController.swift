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
    let goodColor = UIColor.green.cgColor
    let okColor = UIColor.systemYellow.cgColor
    let badColor = UIColor.red.cgColor
    let containerDimension = Constants.widthOfDisplay * 0.3
    var label = UILabel()
    
    
    let overallResults: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "accentLight")
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
    
    let resultsViewFlickerIndex: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "mainColor")
        label.textAlignment = .center
        label.textColor = UIColor(named: "accentLight")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultsViewHertz: UILabel = {
         let label = UILabel()
         label.backgroundColor = UIColor.clear
         label.textAlignment = .center
         label.textColor = UIColor(named: "accentLight")
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
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Percent", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
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
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Index", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
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
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        label.attributedText = attributedText
        return label
    }()
    
    //Underlying track for animation flicker percent
    let trackLayerPercent: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(named: "mainColorAccentLight")?.cgColor
        trackLayer.lineWidth = 8
        return trackLayer
    }()
    
    let animationLayerPercent: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.lineWidth = 8
        animationLayer.strokeEnd = 0
        return animationLayer
    }()
    
    //Underlying track for animation flicker index
    let trackLayerFlickerIndex: CAShapeLayer = {
        let trackLayer = CAShapeLayer()
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = UIColor(named: "mainColorAccentLight")?.cgColor
        trackLayer.lineWidth = 8
        return trackLayer
    }()
    
    let animationLayerFlickerIndex: CAShapeLayer = {
        let animationLayer = CAShapeLayer()
        animationLayer.fillColor = UIColor.clear.cgColor
        animationLayer.lineWidth = 8
        animationLayer.strokeEnd = 0
        return animationLayer
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainColor")
        self.view.addSubview(overallResults)

        self.view.addSubview(percentResultsContainer)
        percentResultsContainer.addSubview(resultsViewPercent)
        percentResultsContainer.layer.addSublayer(trackLayerPercent)
        percentResultsContainer.layer.addSublayer(animationLayerPercent)
        makeGraphic(score: flickerPercent, trackLayer: trackLayerPercent, animationLayer: animationLayerPercent)
        self.view.addSubview(flickerPercentTitle)
        
        self.view.addSubview(flickerIndexResultsContainer)
        flickerIndexResultsContainer.addSubview(resultsViewFlickerIndex)
        flickerIndexResultsContainer.layer.addSublayer(trackLayerFlickerIndex)
        flickerIndexResultsContainer.layer.addSublayer(animationLayerFlickerIndex)
        makeGraphic(score: flickerIndex, trackLayer: trackLayerFlickerIndex, animationLayer: animationLayerFlickerIndex)
        self.view.addSubview(flickerIndexTitle)
        
        self.view.addSubview(hertzResultsContainer)
        hertzResultsContainer.addSubview(resultsViewHertz)
        self.view.addSubview(hertzTitle)
        
        setupLayoutConstraints()

        getNewResults()
    }

    private func setupLayoutConstraints() {
        // overall results display
        overallResults.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topMargin).isActive = true
        overallResults.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overallResults.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        overallResults.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        // percent results container
        percentResultsContainer.topAnchor.constraint(equalTo: overallResults.bottomAnchor, constant: Constants.topMargin).isActive = true
        percentResultsContainer.leadingAnchor.constraint(equalTo: overallResults.leadingAnchor).isActive = true
        percentResultsContainer.heightAnchor.constraint(equalToConstant: containerDimension).isActive = true
        percentResultsContainer.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // percent results display
        resultsViewPercent.centerYAnchor.constraint(equalTo: percentResultsContainer.centerYAnchor).isActive = true
        resultsViewPercent.centerXAnchor.constraint(equalTo: percentResultsContainer.centerXAnchor).isActive = true
        resultsViewPercent.heightAnchor.constraint(equalToConstant: containerDimension).isActive = true
        resultsViewPercent.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // percent title label
        flickerPercentTitle.centerXAnchor.constraint(equalTo: percentResultsContainer.centerXAnchor).isActive = true
        flickerPercentTitle.topAnchor.constraint(equalTo: percentResultsContainer.bottomAnchor).isActive = true
        flickerPercentTitle.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // flicker index results container
        flickerIndexResultsContainer.topAnchor.constraint(equalTo: overallResults.bottomAnchor, constant: Constants.topMargin).isActive = true
        flickerIndexResultsContainer.leadingAnchor.constraint(equalTo: percentResultsContainer.trailingAnchor).isActive = true
        flickerIndexResultsContainer.heightAnchor.constraint(equalToConstant: containerDimension).isActive = true
        flickerIndexResultsContainer.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // flicker index results display
        resultsViewFlickerIndex.centerXAnchor.constraint(equalTo: flickerIndexResultsContainer.centerXAnchor).isActive = true
        resultsViewFlickerIndex.centerYAnchor.constraint(equalTo: flickerIndexResultsContainer.centerYAnchor).isActive = true
        resultsViewFlickerIndex.heightAnchor.constraint(equalToConstant: containerDimension).isActive = true
        resultsViewFlickerIndex.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // flicker index title label
        flickerIndexTitle.centerXAnchor.constraint(equalTo: flickerIndexResultsContainer.centerXAnchor).isActive = true
        flickerIndexTitle.topAnchor.constraint(equalTo: flickerIndexResultsContainer.bottomAnchor).isActive = true
        flickerIndexTitle.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // hertz results container
        hertzResultsContainer.topAnchor.constraint(equalTo: overallResults.bottomAnchor, constant: Constants.topMargin).isActive = true
        hertzResultsContainer.leadingAnchor.constraint(equalTo: flickerIndexResultsContainer.trailingAnchor).isActive = true
        hertzResultsContainer.heightAnchor.constraint(equalToConstant: containerDimension).isActive = true
        hertzResultsContainer.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // hertz results display
        resultsViewHertz.centerYAnchor.constraint(equalTo: hertzResultsContainer.centerYAnchor).isActive = true
        resultsViewHertz.centerXAnchor.constraint(equalTo: hertzResultsContainer.centerXAnchor).isActive = true
        resultsViewHertz.heightAnchor.constraint(equalToConstant: containerDimension).isActive = true
        resultsViewHertz.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        // hertz title label
        hertzTitle.centerXAnchor.constraint(equalTo: hertzResultsContainer.centerXAnchor).isActive = true
        hertzTitle.topAnchor.constraint(equalTo: hertzResultsContainer.bottomAnchor).isActive = true
        hertzTitle.widthAnchor.constraint(equalToConstant: containerDimension).isActive = true
        
        
    }
    
    func getNewResults() {

        let flickerPercentText = String(format: "%.0f", flickerPercent)
        let flickerPercentAttributedText = NSMutableAttributedString(string: flickerPercentText + " %", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        resultsViewPercent.attributedText = flickerPercentAttributedText
        
        let flickerIndexText = String(format: "%.0f", flickerIndex)
        let flickerIndexAttributedText = NSMutableAttributedString(string: flickerIndexText, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        resultsViewFlickerIndex.attributedText = flickerIndexAttributedText
        
        let hertzText = String(format: "%.0f", hertz)
        let hertzAttributedText = NSMutableAttributedString(string: hertzText, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        resultsViewHertz.attributedText = hertzAttributedText
    }
    
    func makeGraphic(score: Double, trackLayer: CAShapeLayer, animationLayer: CAShapeLayer) {
        let radius = containerDimension * 0.375

        //Location for track and for animation
        let center = CGPoint(x: containerDimension * 0.5, y: containerDimension * 0.5)

        //Path for animation and underlying path
        let circularPath = UIBezierPath(arcCenter: center, radius: CGFloat(radius), startAngle: (3 * CGFloat.pi) / 4, endAngle: CGFloat.pi / 4, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        animationLayer.path = circularPath.cgPath
        
        animationLayer.strokeColor = okColor
        
        let scale = CGFloat(score / 100.0)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = scale
        basicAnimation.duration = 1.0
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        animationLayer.add(basicAnimation, forKey: "basic")
        
    }

}
