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

    

    var items = [MoreInfoObject]()
    let cellId = "infoCellId"
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    init(frame: CGRect, contentArray: [MoreInfoObject]) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        items = contentArray
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCell
        let sideeffect = items[indexPath.row]
        cell.imageView.image = UIImage(named: sideeffect.moreInfoImage)
        cell.textView.text = sideeffect.moreInfoText
        return cell
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

