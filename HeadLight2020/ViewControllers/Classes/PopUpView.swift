//
//  PopUpView.swift
//  HeadLight2020
//
//  Created by Ingrid on 28/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

protocol PopUpDelegate {
    func handleDismissal()
}

class PopUpView: UIView {
    
    var delegate: PopUpDelegate?
    
    let closePopUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "accentLight")
        button.layer.cornerRadius = Constants.topMargin / 1.5 / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "xmark")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor(named: "mainColorAccentDark")
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = Constants.popUpHeader
        label.textAlignment = .center
        return label
    }()
    
    let textView: UITextView = {
        let label = UITextView()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.isEditable = false
        label.font = Constants.readingFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(closePopUpButton)
        closePopUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.seperator).isActive = true
        closePopUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        closePopUpButton.widthAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        closePopUpButton.heightAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
    }
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.addSubview(closePopUpButton)
        self.addSubview(titleLabel)
        closePopUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.seperator).isActive = true
        closePopUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        closePopUpButton.widthAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        closePopUpButton.heightAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.sideMargins).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.seperator).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: closePopUpButton.centerYAnchor).isActive = true
        titleLabel.attributedText = attributedTitle(text1: title)
    }
    
    init(frame: CGRect, title: String, text: String) {
        super.init(frame: frame)
        self.addSubview(closePopUpButton)
        self.addSubview(titleLabel)
        self.addSubview(textView)
        closePopUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.seperator).isActive = true
        closePopUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        closePopUpButton.widthAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        closePopUpButton.heightAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.sideMargins).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.seperator).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: closePopUpButton.centerYAnchor).isActive = true
        titleLabel.attributedText = attributedTitle(text1: title)
        
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.sideMargins).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.seperator).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    
    func attributedTitle(text1: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text1, attributes: [NSAttributedString.Key.font: Constants.popUpHeader!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        return attributedText
    }
}

