//
//  Tester.swift
//  HeadLight2020
//
//  Created by Ingrid on 28/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class Tester: UIViewController {
    
    lazy var topView: SwipingController = {
        let tv = SwipingController()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    func addTopView() {
        view.addSubview(topView)

        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topView.backgroundColor = .blue
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTopView()

    }
    

}
