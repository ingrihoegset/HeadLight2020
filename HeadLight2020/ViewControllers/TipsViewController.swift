//
//  HowToUse.swift
//  HeadLight2020
//
//  Created by Ingrid on 27/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit


class TipsViewController: UIViewController {
    
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
        let text = Constants.tips
        label.font = Constants.pageHeaderFont
        label.text = text
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tip1View: UIView = {
        let view = HowToSlide(frame: .zero, image: "Introduction", text: TipsTexts.tip1, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tip2View: UIView = {
        let view = HowToSlide(frame: .zero, image: "LedLys", text: TipsTexts.tip2, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tip3View: UIView = {
        let view = HowToSlide(frame: .zero, image: "Dimming", text: TipsTexts.tip3, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tip4View: UIView = {
        let view = HowToSlide(frame: .zero, image: "FlourescentTube", text: TipsTexts.tip4, fill: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tip5View: UIView = {
        let view = HowToSlide(frame: .zero, image: "Bulb", text: TipsTexts.tip5, fill: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tip6View: UIView = {
        let view = HowToSlide(frame: .zero, image: "Curtains", text: TipsTexts.tip6, fill: false)
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
        swiper.items = [tip1View, tip2View, tip3View, tip4View, tip5View, tip6View]
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
