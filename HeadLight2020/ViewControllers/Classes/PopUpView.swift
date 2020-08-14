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
        button.setImage(UIImage(named: "Exit"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "accentLight")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(closePopUpButton)
        closePopUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.verticalMargins).isActive = true
        closePopUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.sideMargins).isActive = true
        closePopUpButton.widthAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        closePopUpButton.heightAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
    }
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.addSubview(closePopUpButton)
        self.addSubview(titleLabel)
        closePopUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.verticalMargins).isActive = true
        closePopUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.seperator).isActive = true
        closePopUpButton.widthAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        closePopUpButton.heightAnchor.constraint(equalToConstant: Constants.topMargin / 1.5).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.sideMargins).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.seperator).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: closePopUpButton.leadingAnchor, constant: -Constants.sideMargins).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: closePopUpButton.centerYAnchor).isActive = true
        titleLabel.attributedText = attributedTitle(text1: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    
    func attributedTitle(text1: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text1, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor(named: "accentLight")!])
        return attributedText
    }
}

