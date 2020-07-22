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
    
    var flickerPercent = 0.0
    var flickerIndex = 0.0
    var hertz = 0.0
    
    let ResultsView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.textAlignment = .center
        view.textColor = UIColor(named: "accentLight")
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ResultsViewHertz: UITextView = {
         let view = UITextView()
         view.backgroundColor = UIColor.gray
         view.textAlignment = .center
         view.textColor = UIColor(named: "accentLight")
         view.isEditable = false
         view.isScrollEnabled = false
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
     let ResultsViewPercent: UITextView = {
         let view = UITextView()
         view.backgroundColor = UIColor.red
         view.textAlignment = .center
         view.textColor = UIColor(named: "accentLight")
         view.isEditable = false
         view.isScrollEnabled = false
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(flickerPercent)
        self.view.addSubview(ResultsView)
        self.view.addSubview(ResultsViewHertz)
        self.view.addSubview(ResultsViewPercent)
        setupLayoutConstraints()
        getNewResults()
    }

    private func setupLayoutConstraints() {
        // results display
        ResultsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ResultsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ResultsView.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.1).isActive = true
        ResultsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        // hertz results display
        ResultsViewHertz.topAnchor.constraint(equalTo: ResultsView.bottomAnchor).isActive = true
        ResultsViewHertz.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ResultsViewHertz.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.1).isActive = true
        ResultsViewHertz.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        // percent results display
        ResultsViewPercent.topAnchor.constraint(equalTo: ResultsViewHertz.bottomAnchor).isActive = true
        ResultsViewPercent.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ResultsViewPercent.heightAnchor.constraint(equalTo: view.heightAnchor,  multiplier: 0.1).isActive = true
        ResultsViewPercent.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func getNewResults() {
        ResultsView.text = "FI: " + String(Int(flickerIndex.rounded()))
        ResultsViewHertz.text = "Hertz: " + String(Int(hertz.rounded()))
        ResultsViewPercent.text = "FP: " + String(Int(flickerPercent.rounded())) + " %"
    }
}
