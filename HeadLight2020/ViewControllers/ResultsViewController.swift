//
//  ResultsViewController.swift
//  HeadLight2020
//
//  Created by Ingrid on 06/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    let viewModel = CameraViewModel()
    
    let temporaryResultsView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.textAlignment = .center
        view.textColor = UIColor(named: "accentLight")
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(temporaryResultsView)
        temporaryResultsView.text = viewModel.flickerResult
        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {
        //Temporary results display
        temporaryResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temporaryResultsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temporaryResultsView.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.1).isActive = true
        temporaryResultsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    }
    
}
