//
//  SwipingController.swift
//  HeadLight2020
//
//  Created by Ingrid on 28/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class SwipingController: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    

    let items = ["1","2","3","4","5","6","7","8"]
    let cellId = "infoCellId"
    


    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .clear
        setupViews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
       return collectionView
    }()
    
    
    func setupViews() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InfoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.frame.width, height: self.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    

    
    

}


class InfoCell: UICollectionViewCell {
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.layer.cornerRadius = Constants.largeContainerDimension * 0.8 / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Best")
        view.image = image
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.text = "Some information"
        view.isUserInteractionEnabled = false
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
        container.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -2 * Constants.sideMargins).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.sideMargins).isActive = true
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.sideMargins).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        imageView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        imageView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        textView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.verticalMargins).isActive = true
        textView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    }
    
}
