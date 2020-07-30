//
//  PulseAnimation.swift
//  HeadLight2020
//
//  Created by Ingrid on 26/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class PulseAnimation: CALayer {
    
    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 1.2
    var radius: CGFloat = 200
    var numberOfPulses: Float = 10
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementer")
    }
    
    init(numberOfPulses: Float, radius: CGFloat, position: CGPoint, color: CGColor, duration: TimeInterval) {
        super.init()
        self.backgroundColor = color
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setUpAnimationGroup(duration: duration)
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = 0.8
        scaleAnimation.toValue = 1.2
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        opacityAnimation.keyTimes = [0, 0.2, 1]
        opacityAnimation.values = [0, 0.1, 0.3]
        return opacityAnimation
    }
    
    func setUpAnimationGroup(duration: TimeInterval) {
        self.animationGroup.duration = duration
        self.animationGroup.repeatCount = numberOfPulses
        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.autoreverses = true
        self.animationGroup.animations = [scaleAnimation(), createOpacityAnimation()]
    }
}
