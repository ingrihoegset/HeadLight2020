//
//  SideEffect.swift
//  HeadLight2020
//
//  Created by Ingrid on 02/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class MoreInfoObject: UIView {
    
    let moreInfoText: String
    let moreInfoImage: String
    
    let sideEffectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let sideEffectsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let noRisk: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.text = "No Risk"
        label.font = UIFont(name: "Poppins-ExtraLight", size: 12)!
        label.textColor = UIColor(named: "mainColorAccentDark")
        return label
    }()
    
    let highRisk: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.text = "High Risk"
        label.font = UIFont(name: "Poppins-ExtraLight", size: 12)!
        label.textColor = UIColor(named: "mainColorAccentDark")
        return label
    }()
    
    let sideEffectContainer: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        return view
    }()
    
    let timerFillerLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 18
        layer.strokeEnd = 0
        layer.lineCap = .round
        return layer
    }()
    
    init(frame: CGRect, image: String, title1: String, title2: String, moreInfoText: String) {
        self.moreInfoImage = image
        self.moreInfoText = moreInfoText
        super.init(frame: frame)
        sideEffectsTitle.attributedText = setAttributedText(text1: title1, text2: title2)
        sideEffectContainer.image = UIImage(named: moreInfoImage)
        self.addSubview(sideEffectContainer)
        self.addSubview(sideEffectsTitle)
        self.addSubview(sideEffectView)
        sideEffectView.addSubview(noRisk)
        sideEffectView.addSubview(highRisk)
        setConstraints()
    }
    
    init(frame: CGRect, image: String, title1: String, title2: String, moreInfoText: String, risk: Double) {
        self.moreInfoImage = image
        self.moreInfoText = moreInfoText
        super.init(frame: frame)
        sideEffectsTitle.attributedText = setAttributedText(text1: title1, text2: title2)
        sideEffectContainer.image = UIImage(named: moreInfoImage)
        self.addSubview(sideEffectContainer)
        self.addSubview(sideEffectsTitle)
        self.addSubview(sideEffectView)
        sideEffectView.addSubview(noRisk)
        sideEffectView.addSubview(highRisk)
        setConstraints()
        makeTimerGraphic(score: risk, filler: timerFillerLayer)
    }
    
    override init(frame: CGRect) {
        self.moreInfoText = ""
        self.moreInfoImage = ""
        super.init(frame: .zero)
        sideEffectContainer.backgroundColor = UIColor.clear
        self.addSubview(sideEffectContainer)
        self.addSubview(sideEffectsTitle)
        setConstraints()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        // side effect container
         sideEffectContainer.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
         sideEffectContainer.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
         
         // side effects title
         sideEffectsTitle.topAnchor.constraint(equalTo: sideEffectContainer.bottomAnchor).isActive = true
         sideEffectsTitle.centerXAnchor.constraint(equalTo: sideEffectContainer.centerXAnchor).isActive = true
         sideEffectsTitle.widthAnchor.constraint(equalTo: sideEffectContainer.widthAnchor).isActive = true
        
        // side effects title
        sideEffectView.leadingAnchor.constraint(equalTo: sideEffectContainer.trailingAnchor).isActive = true
        sideEffectView.centerYAnchor.constraint(equalTo: sideEffectContainer.centerYAnchor).isActive = true
        sideEffectView.widthAnchor.constraint(equalToConstant: Constants.containerDimension * 2).isActive = true
        sideEffectView.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        
        // no risk label
        noRisk.leadingAnchor.constraint(equalTo: sideEffectView.leadingAnchor).isActive = true
        noRisk.bottomAnchor.constraint(equalTo: sideEffectView.bottomAnchor).isActive = true
        
        // high risk label
        highRisk.trailingAnchor.constraint(equalTo: sideEffectView.trailingAnchor).isActive = true
        highRisk.bottomAnchor.constraint(equalTo: sideEffectView.bottomAnchor).isActive = true
    }
    
    func setAttributedText(text1: String, text2: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text1 + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: text2, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        return attributedText
    }
    
    
    func makeTimerGraphic(score: Double, filler: CAShapeLayer) {

        let startOfPathX = 0 + Constants.sideMargins * 2
        let endOfPathX = Constants.containerDimension * 2
        let segmentSize = (endOfPathX - startOfPathX) / 4
        let endpoint = score / 100
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
            
            self.sideEffectView.layer.addSublayer(segments[i])

        }
        
        if (endpoint <= 0.25) {
            timerFillerLayer.strokeColor = UIColor.green.cgColor
        }
        else if (endpoint <= 0.50) {
            timerFillerLayer.strokeColor = UIColor.yellow.cgColor
        }
        else if (endpoint <= 0.75) {
            timerFillerLayer.strokeColor = UIColor.red.cgColor
        }
        else {
            timerFillerLayer.strokeColor = UIColor(named: "darkRed")?.cgColor
        }
        sideEffectView.layer.addSublayer(timerFillerLayer)
            
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
}
