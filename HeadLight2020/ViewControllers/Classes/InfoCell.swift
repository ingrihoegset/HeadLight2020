//
//  InfoCell.swift
//  HeadLight2020
//
//  Created by Ingrid on 02/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit


class InfoCell: UICollectionViewCell {
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = .clear
        return view
    }()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = Constants.largeContainerDimension * 0.4 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        let image = UIImage(named: "Best")
        view.image = image
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "mainColorAccentDark")
        view.text = "Some information"
        view.font = UIFont(name: "Poppins-Light", size: 18)
        view.textAlignment = .center
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.isScrollEnabled = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.cornerRadius = Constants.cornerRadius
        self.addSubview(container)
        container.addSubview(imageView)
        container.addSubview(textView)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        container.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -4 * Constants.sideMargins).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.sideMargins).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.sideMargins).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        imageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45).isActive = true
        imageView.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.45).isActive = true
        imageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        textView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -1.5 * Constants.verticalMargins).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
}
