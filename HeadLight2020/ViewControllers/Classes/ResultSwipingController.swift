//
//  SwipingController.swift
//  HeadLight2020
//
//  Created by Ingrid on 28/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class ResultSwipingController: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var items = [UIView]()
    let cellId = "infoCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    init(frame: CGRect, contentArray: [UIView]) {
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
        collectionView.layer.cornerRadius = Constants.radiusContainers
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
       return collectionView
    }()
    
    let dots: UIPageControl = {
        let controller = UIPageControl()
        controller.currentPageIndicatorTintColor = UIColor(named: "accentLight")
        controller.backgroundColor = .clear
        controller.layer.cornerRadius = Constants.cornerRadius
        controller.pageIndicatorTintColor = UIColor(named: "mainColorAccentDark")
        controller.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    
    func setupViews() {

        addSubview(dots)
        dots.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dots.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dots.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        dots.heightAnchor.constraint(equalToConstant: 1.5 * Constants.verticalMargins).isActive = true
        
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ResultsCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ResultsCell
        let view = items[indexPath.row]
        cell.container.addSubview(view)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dots.numberOfPages = items.count
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dots.currentPage = Int(
            (collectionView.contentOffset.x / collectionView.frame.width)
            .rounded(.toNearestOrAwayFromZero)
        )
    }


}



