//
//  RestoreController.swift
//  HeadLight2020
//
//  Created by Ingrid on 07/09/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit
import StoreKit

class RestoreController: UIViewController {
    
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
        label.font = Constants.logoFont
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "mainColorAccentDark")
        button.setTitle("Restore Purchase", for: .normal)
        button.setTitleColor(UIColor(named: "mainColorAccentDark"), for: .normal)
        button.setTitleColor(UIColor(named: "mainColorAccentLight"), for: .selected)
        button.titleLabel?.font = Constants.pageHeaderFont
        button.addTarget(self, action: #selector(restorePurchase), for: .touchUpInside)
        button.layer.cornerRadius = Constants.heightOfDisplay * 0.05
        button.backgroundColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainColor")
        
        view.addSubview(button)
        view.addSubview(topPanelView)
        topPanelView.addSubview(titleLabel)
        
        setConstraints()

    }
    
    func setConstraints() {
        //Constraints of top panel
        topPanelView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topPanelView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topPanelView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topPanelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //Top panel title
        titleLabel.centerXAnchor.constraint(equalTo: topPanelView.centerXAnchor
        ).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Constants.topMargin).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        button.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.75).isActive = true
    }
    
    @objc func restorePurchase() {
        SKPaymentQueue.default().restoreCompletedTransactions()
        self.view.isHidden = true
    }

}
