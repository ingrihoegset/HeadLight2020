
//
//  HowToUse.swift
//  HeadLight2020
//
//  Created by Ingrid on 27/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class WelcomePage: UIViewController {
    
    let WelcomeTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        let text = "Welcome to"
        let attributedText = NSMutableAttributedString(string: text + "\n", attributes: [NSAttributedString.Key.font: Constants.pageHeaderFont!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: "Headlight", attributes: [NSAttributedString.Key.font: Constants.logoFontLarge!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        view.attributedText = attributedText
        view.textAlignment = .center
        view.numberOfLines = 2
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Welcome")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let letsGoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "mainColorAccentDark")
        button.setTitle("Get started", for: .normal)
        button.setTitleColor(UIColor(named: "accentLight"), for: .normal)
        button.setTitleColor(UIColor(named: "mainColorAccentLight"), for: .selected)
        button.titleLabel?.font = Constants.pageHeaderFont
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.layer.cornerRadius = Constants.heightOfDisplay * 0.05
        button.isHidden = false
        return button
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "mainColor")
        return view
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "accentLight")
        view.addSubview(WelcomeTitle)
        view.addSubview(imageView)
        view.addSubview(bottomView)
        view.addSubview(letsGoButton)
        setConstraints()
    }
    
    func setConstraints() {
        WelcomeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.seperator).isActive = true
        WelcomeTitle.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.6).isActive = true
        WelcomeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        WelcomeTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: WelcomeTitle.bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        
        letsGoButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        letsGoButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        letsGoButton.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.5).isActive = true
        letsGoButton.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.1).isActive = true

    }
    
    @objc func dismissView() {
        self.view.isHidden = true
    }
}
