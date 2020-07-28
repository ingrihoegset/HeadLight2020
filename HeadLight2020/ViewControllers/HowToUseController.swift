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
        label.font = UIFont(name: "Poppins-ExtraLight", size: 20)
        return label
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green
        label.text = "Page Title"
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Italic", size: 26)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .cyan
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let verticalContainer: UIStackView = {
        let container = UIStackView()
        container.backgroundColor = UIColor.purple
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.distribution = .fillProportionally
        return container
    }()
    
    let subTitle1: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.orange
        label.text = "Subtitle 1"
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Italic", size: 20)
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .yellow
        view.text = "blablabbaballablabla"
        return view
    }()
    
    let subTitle2: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.orange
        label.text = "Subtitle 2"
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Italic", size: 20)
        return label
    }()
    
    let textView2: UITextView = {
        let view = UITextView()
        view.backgroundColor = .gray
        view.text = "fgiuhvndv"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        view.addSubview(pageTitle)
        view.addSubview(scrollView)
   
        scrollView.addSubview(verticalContainer)
        
        textView.addSubview(subTitle1)
        textView2.addSubview(subTitle2)
        
        verticalContainer.addArrangedSubview(textView)
        verticalContainer.addArrangedSubview(textView2)

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
        verticalContainer.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        verticalContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        //First Subtitle
        subTitle1.topAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        subTitle1.widthAnchor.constraint(equalTo: textView.widthAnchor).isActive = true
        subTitle1.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
        
        //Second Subtitle
        subTitle2.topAnchor.constraint(equalTo: textView2.topAnchor).isActive = true
        subTitle2.widthAnchor.constraint(equalTo: textView2.widthAnchor).isActive = true
        subTitle2.leadingAnchor.constraint(equalTo: textView2.leadingAnchor).isActive = true
        

        
    }
}
