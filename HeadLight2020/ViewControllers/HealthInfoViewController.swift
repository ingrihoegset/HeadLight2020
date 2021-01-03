//
//  HowToUse.swift
//  HeadLight2020
//
//  Created by Ingrid on 27/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit


class HealthInfoViewController: UIViewController {
    
    let topPanelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "Headlight"
        label.textColor = UIColor(named: "accentLight")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.logoFont
        return label
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        let text = Constants.health
        label.font = Constants.pageHeaderFont
        label.text = text
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let feelBadView: UIView = {
        let view = HowToSlide(frame: .zero, image: "FeelBad", text: HealthTexts.didYouKnow, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let eyestrainView: UIView = {
        let view = HowToSlide(frame: .zero, image: "EyestrainImage", text: HealthTexts.eyestrain, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let vertigoView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Vertigo", text: /*HealthTexts.vertigo*/ "It may lead to blurred vision.", fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headacheMigraineView: UIView = {
        let view = HowToSlide(frame: .zero, image: "HeadacheMigraine", text: HealthTexts.headache, fill: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fatigueView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Fatigue", text: HealthTexts.fatigue, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let whatToDoView: UIView = {
        let view = HowToSlide(frame: .zero, image: "Detection", text: HealthTexts.whatToDo, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let swiper: HowToSwiperController = {
        let swiper = HowToSwiperController(frame: .zero)
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        view.addSubview(pageTitle)
        swiper.items = [feelBadView, eyestrainView, vertigoView, headacheMigraineView/*, fatigueView*/, whatToDoView]
        view.addSubview(swiper)
        setConstraints()
    }
    
    func setConstraints() {
        //Constraints of top panel
        topPanelView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topPanelView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topPanelView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topPanelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Top panel title
        titleLabel.centerXAnchor.constraint(equalTo: topPanelView.centerXAnchor
        ).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Tilte of page
        pageTitle.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageTitle.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pageTitle.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        
        //Swiper
        swiper.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        swiper.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        swiper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiper.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
