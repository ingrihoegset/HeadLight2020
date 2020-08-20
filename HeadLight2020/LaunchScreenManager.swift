//
//  LaunchScreenManager.swift
//  HeadLight2020
//
//  Created by Ingrid on 14/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit

class LaunchScreenManager {

    // MARK: - Properties

    // Using a singleton instance and setting animationDurationBase on init makes this class easier to test
    static let instance = LaunchScreenManager(animationDurationBase: 1)

    var view: UIView?
    var parentView: UIView?
    let animationDurationBase: Double


    // MARK: - Lifecycle

    init(animationDurationBase: Double) {
        self.animationDurationBase = animationDurationBase
    }


    // MARK: - Animation

    func animateAfterLaunch(_ parentViewPassedIn: UIView) {

        parentView = parentViewPassedIn
        view = loadView()
        fillParentViewWithView()
        animation()
    }

    func loadView() -> UIView {
        return UINib(nibName: "Launcher", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func fillParentViewWithView() {
        parentView!.addSubview(view!)
        view!.frame = parentView!.bounds
        view!.center = parentView!.center
    }
    
    func animation() {

        let launchImage = view!.viewWithTag(1)!
        let backgroudview = view!.viewWithTag(0)!

        launchImage.transform = CGAffineTransform.identity
        launchImage.alpha = 0.5
    
        UIView.animate(
            withDuration: animationDurationBase,
            delay: 0.25,
            options: .beginFromCurrentState,
            animations: {
                launchImage.alpha = 1.0
                backgroudview.alpha = 1.0
                launchImage.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }
        )
    
        UIView.animate(
            withDuration: animationDurationBase,
            delay: 0.25,
            options: .beginFromCurrentState,
            animations: {
                launchImage.alpha = 0
                backgroudview.alpha = 0

            },
            completion: { _ in
                self.view!.removeFromSuperview()
            }
        )
    }
}

