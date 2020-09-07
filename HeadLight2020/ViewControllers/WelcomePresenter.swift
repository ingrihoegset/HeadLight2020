
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
    
    let feelBadView: UIView = {
        let view = HowToSlide(frame: .zero, image: "FeelBad", text: LaunchTexts.wellbeing, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let useHeadlightVIew: UIView = {
        let view = HowToSlide(frame: .zero, image: "Introduction", text: LaunchTexts.use, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let captureView: UIView = {
        let view = HowToSlide(frame: .zero, image: "CaptureOrange", text: LaunchTexts.capture, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detectionView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Detection", text: LaunchTexts.point, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let howToHoldView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Holding", text: HowToUseText.slide4, fill: true)
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
        button.backgroundColor = UIColor(named: "mainColorAccentDark")
        button.setTitle("Let's Go!", for: .normal)
        button.setTitleColor(UIColor(named: "accentLight"), for: .normal)
        button.setTitleColor(UIColor(named: "mainColorAccentLight"), for: .selected)
        button.titleLabel?.font = Constants.pageHeaderFont
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.layer.cornerRadius = Constants.heightOfDisplay * 0.05
        button.isHidden = true
        return button
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "accentLight")
        swiper.items = [feelBadView, useHeadlightVIew, detectionView, captureView, howToHoldView]
        view.addSubview(swiper)

        view.addSubview(letsGoButton)
        setConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLetsGoButton), name: NSNotification.Name.init(rawValue: "showLetsGoButton"), object: nil)
    }
    
    func setConstraints() {
        
        //Swiper
        swiper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        swiper.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        swiper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiper.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        letsGoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        letsGoButton.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.5).isActive = true
        letsGoButton.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.1).isActive = true
        letsGoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalMargins).isActive = true

    }
    
    @objc func dismissView() {
        //Sets the bool to true so the app knows that the user has opened the app before and does not need to be presented with
        //the welcome & on-boarding screen
        Constants.userDefaultFirstLaunch.set(true, forKey: Constants.firstLaunch)
        self.view.isHidden = true
    }
    
    @objc func showLetsGoButton() {
        self.letsGoButton.isHidden = false
    }
    
    
}
