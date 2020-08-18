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
        label.text = Constants.howTo
        label.textColor = UIColor(named: "accentLight")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 26)
        return label
    }()
    
    let introView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewHeight = Constants.heightOfDisplay - Constants.topMargin * 2
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Introduction")
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewHeight * 0.7).isActive = true
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.font = Constants.readingFont
        textView.text = HowToUseText.slide1
        view.addSubview(textView)
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        return view
    }()
    
    let nightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewHeight = Constants.heightOfDisplay - Constants.topMargin * 2
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Night")
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewHeight * 0.7).isActive = true
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.font = Constants.readingFont
        textView.text = "cfg"
        view.addSubview(textView)
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        return view
    }()
    
    let detectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewHeight = Constants.heightOfDisplay - Constants.topMargin * 2
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Detection")
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewHeight * 0.7).isActive = true
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.font = Constants.readingFont
        textView.text = "fghijkojiohug iyuftdry ytfyguhijokoji hougiyfu"
        view.addSubview(textView)
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        return view
    }()
    
    let howToHoldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewHeight = Constants.heightOfDisplay - Constants.topMargin * 2
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Holding")
        view.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewHeight * 0.7).isActive = true
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = false
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.font = Constants.readingFont
        textView.text = "dfghjkl"
        view.addSubview(textView)
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        return view
    }()
    
    let swiper: ResultSwipingController = {
        let swiper = ResultSwipingController(frame: .zero)
        swiper.translatesAutoresizingMaskIntoConstraints = false
        return swiper
    }()

 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        view.addSubview(pageTitle)
        
        swiper.items = [introView, detectView, howToHoldView, nightView]
        
        view.addSubview(swiper)


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
        
        //Swiper
        swiper.topAnchor.constraint(equalTo: pageTitle.bottomAnchor).isActive = true
        swiper.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        swiper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiper.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //Image views
        nightView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        nightView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay - Constants.topMargin * 2).isActive = true
        
        detectView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        detectView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay - Constants.topMargin * 2).isActive = true
        
        introView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        introView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay - Constants.topMargin * 2).isActive = true
        
        howToHoldView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        howToHoldView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay - Constants.topMargin * 2).isActive = true
        
    
    }
}
