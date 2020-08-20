//
//  HowToSlide.swift
//  HeadLight2020
//
//  Created by Ingrid on 19/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit


class HowToSlide: UIView {
    
    var image: String
    var text: String
    let viewHeight = Constants.heightOfDisplay - Constants.topMargin * 2
    var fill: Bool
    
     let imageView: UIImageView = {
         let view = UIImageView()
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
            
     let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        self.image = ""
        self.text = ""
        self.fill = false
        super.init(frame: frame)
    }
    
    init(frame: CGRect, image: String, text: String, fill: Bool) {
        self.fill = fill
        self.image = image
        self.text = text
        super.init(frame: frame)
        imageView.image = UIImage(named: image)
        textView.text = text
        self.addSubview(imageView)
        self.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
