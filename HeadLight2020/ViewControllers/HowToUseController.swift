//
//  HowToUse.swift
//  HeadLight2020
//
//  Created by Ingrid on 27/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit


class HowToUseController: UIViewController {
    
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
        let text = Constants.howTo
        let attributedText = NSMutableAttributedString(string: text + " ", attributes: [NSAttributedString.Key.font: Constants.pageHeaderFont!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        attributedText.append(NSAttributedString(string: "Headlight", attributes: [NSAttributedString.Key.font: UIFont(name: "GrandHotel-Regular", size: 24)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!]))
        label.attributedText = attributedText
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        view.addSubview(pageTitle)
        swiper.items = [detectView, captureView, howToHoldView, nightView]
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
