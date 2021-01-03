//
//  InfoCell.swift
//  HeadLight2020
//
//  Created by Ingrid on 02/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit


class HowToCell: UICollectionViewCell {
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = .clear
        return view
    }()
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var imageViewFill: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSelectable = false
        view.textAlignment = .center
        view.backgroundColor = .clear
        view.textColor = .black
        view.font = UIFont(name: "Poppins-Light", size: 18)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layer.cornerRadius = Constants.cornerRadius
        self.addSubview(container)
        container.addSubview(imageView)
        container.addSubview(imageViewFill)
        container.addSubview(textView)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        container.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.65).isActive = true
        
        imageViewFill.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageViewFill.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        imageViewFill.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        imageViewFill.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.65).isActive = true
        
        textView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constants.verticalMargins).isActive = true
        textView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.seperator).isActive = true
        textView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.seperator).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        

    }
    
}
