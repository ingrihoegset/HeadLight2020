//
//  SideEffect.swift
//  HeadLight2020
//
//  Created by Ingrid on 02/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class MoreInfoObject: UIView {
    
    let moreInfoText: String
    let moreInfoImage: String
    
    let sideEffectsTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        return label
    }()
    
    let sideEffectContainer: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(named: "accentLight")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.smallContainerDimensions / 2
        return view
    }()
    
    init(frame: CGRect, image: String, title1: String, title2: String, moreInfoText: String) {
        self.moreInfoImage = image
        self.moreInfoText = moreInfoText
        super.init(frame: frame)
        sideEffectsTitle.attributedText = setAttributedText(text1: title1, text2: title2)
        sideEffectContainer.image = UIImage(named: moreInfoImage)
        self.addSubview(sideEffectContainer)
        self.addSubview(sideEffectsTitle)
        setConstraints()
    }
    
    override init(frame: CGRect) {
        self.moreInfoText = ""
        self.moreInfoImage = ""
        super.init(frame: .zero)
        sideEffectContainer.backgroundColor = UIColor.clear
        self.addSubview(sideEffectContainer)
        self.addSubview(sideEffectsTitle)
        setConstraints()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints() {
        // side effect container
         sideEffectContainer.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
         sideEffectContainer.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
         
         // side effects title
         sideEffectsTitle.topAnchor.constraint(equalTo: sideEffectContainer.bottomAnchor).isActive = true
         sideEffectsTitle.centerXAnchor.constraint(equalTo: sideEffectContainer.centerXAnchor).isActive = true
         sideEffectsTitle.widthAnchor.constraint(equalTo: sideEffectContainer.widthAnchor).isActive = true
    }
    
    func setAttributedText(text1: String, text2: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: text1 + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!])
        attributedText.append(NSAttributedString(string: text2, attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins-ExtraLight", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor(named: "mainColorAccentDark")!]))
        return attributedText
    }
    
}
