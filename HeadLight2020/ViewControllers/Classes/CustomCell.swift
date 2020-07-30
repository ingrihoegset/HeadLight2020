//
//  CustomCell.swift
//  HeadLight2020
//
//  Created by Ingrid on 27/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    let icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.backgroundColor = .clear
        return icon
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(name)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {

        icon.widthAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        icon.heightAnchor.constraint(equalToConstant: Constants.smallContainerDimensions).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.sideMargins).isActive = true

        name.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.sideMargins).isActive = true
        name.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
    }
    
    
}
