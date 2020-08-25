
//
//  HowToUse.swift
//  HeadLight2020
//
//  Created by Ingrid on 27/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class WelcomePresenter: UIViewController {
    
    let introView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Introduction", text: HowToUseText.slide1, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detectView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Detection", text: HowToUseText.slide2, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let captureView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Capture", text: HowToUseText.slide3, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let howToHoldView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Holding", text: HowToUseText.slide4, fill: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nightView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Night", text: HowToUseText.slide5, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
 
    let swiper: HowToSwiperController = {
        let swiper = HowToSwiperController(frame: .zero)
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()
    
    let letsGoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Let's Go!", for: .normal)
        button.setTitleColor(UIColor(named: "mainColorAccentDark"), for: .normal)
        button.setTitleColor(UIColor(named: "mainColorAccentLight"), for: .selected)
        button.titleLabel?.font = Constants.logoFontLarge
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "accentLight")
        swiper.items = [introView, detectView, captureView, howToHoldView, nightView]
        view.addSubview(swiper)
        view.addSubview(letsGoButton)
        setConstraints()
    }
    
    func setConstraints() {
        //Swiper
        swiper.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swiper.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        swiper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiper.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80).isActive = true

        letsGoButton.topAnchor.constraint(equalTo: swiper.bottomAnchor).isActive = true
        letsGoButton.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        letsGoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        letsGoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    @objc func dismissView() {
        //Sets the bool to true so the app knows that the user has opened the app before and does not need to be presented with
        //the welcome & on-boarding screen
        Constants.userDefaultFirstLaunch.set(true, forKey: Constants.firstLaunch)
        self.view.isHidden = true
    }
}
