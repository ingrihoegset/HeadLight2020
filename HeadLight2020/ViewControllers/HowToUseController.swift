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
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        return label
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "mainColorAccentDark")
        label.text = "Page Title"
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 26)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: "accentLight")
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let verticalContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.distribution = .fillEqually
        container.backgroundColor = UIColor.purple
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let firstView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subTitle1: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "accentLight")
        label.text = "Subtitle 1"
        label.textColor = UIColor(named: "mainColorAccentDak")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "accentLight")
        view.sizeToFit()
        view.text = "blablabbaballablabla"
        return view
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let subTitle2: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "accentLight")
        label.text = "Subtitle 2"
        label.textColor = UIColor(named: "mainColorAccentDark")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 20)
        return label
    }()
    
    let textView2: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "accentLight")
        view.text = "fgiuhvndv"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        view.addSubview(pageTitle)

        firstView.addSubview(subTitle1)
        firstView.addSubview(textView)
        
        secondView.addSubview(subTitle2)
        secondView.addSubview(textView2)
        
        view.addSubview(scrollView)
        scrollView.addSubview(verticalContainer)
        verticalContainer.addSubview(firstView)
        verticalContainer.addSubview(secondView)

        setConstraints()

    }
    
    func setConstraints() {
        //Constraints of top panel
        topPanelView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topPanelView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topPanelView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topPanelView.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        
        //Top panel title
        titleLabel.centerXAnchor.constraint(equalTo: topPanelView.centerXAnchor
        ).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: topPanelView.heightAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: topPanelView.centerYAnchor).isActive = true
        
        //Tilte of page
        pageTitle.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageTitle.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageTitle.topAnchor.constraint(equalTo: topPanelView.bottomAnchor).isActive = true
        pageTitle.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        
        //ScrollView
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //Vertical Container
        verticalContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        verticalContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        verticalContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        verticalContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        verticalContainer.heightAnchor.constraint(equalToConstant: 800).isActive = true
        verticalContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        firstView.topAnchor.constraint(equalTo: verticalContainer.topAnchor, constant: Constants.verticalMargins).isActive = true
        firstView.leadingAnchor.constraint(equalTo: verticalContainer.leadingAnchor).isActive = true
        firstView.trailingAnchor.constraint(equalTo: verticalContainer.trailingAnchor).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
        
        subTitle1.topAnchor.constraint(equalTo: firstView.topAnchor).isActive = true
        subTitle1.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: Constants.seperator).isActive = true
        subTitle1.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -Constants.seperator).isActive = true
        
        textView.topAnchor.constraint(equalTo: subTitle1.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
        
        secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        secondView.leadingAnchor.constraint(equalTo: verticalContainer.leadingAnchor).isActive = true
        secondView.trailingAnchor.constraint(equalTo: verticalContainer.trailingAnchor).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
        
        subTitle2.topAnchor.constraint(equalTo: secondView.topAnchor).isActive = true
        subTitle2.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: Constants.seperator).isActive = true
        subTitle2.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -Constants.seperator).isActive = true

        textView2.topAnchor.constraint(equalTo: subTitle2.bottomAnchor).isActive = true
        textView2.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: Constants.seperator).isActive = true
        textView2.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView2.heightAnchor.constraint(equalToConstant: Constants.containerDimension).isActive = true
    }
}
