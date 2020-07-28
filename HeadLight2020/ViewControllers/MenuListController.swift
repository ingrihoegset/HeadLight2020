//
//  MenuListController.swift
//  HeadLight2020
//
//  Created by Ingrid on 26/07/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit

class MenuListController: UITableViewController {
    
    var items = ["Home", "Second", "Third", "Fourth"]
    let icons = ["Info", "Info", "Info", "Info"]
    var delegate: MenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        self.view.backgroundColor = UIColor(named: "mainColor")
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.smallContainerDimensions * 1.5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor(named: "mainColor")
        cell.name.font = UIFont(name: "Poppins-Italic", size: 20)
        cell.name.textColor = UIColor(named: "accentLight")
        cell.name.text = items[indexPath.row]
        cell.icon.image = UIImage(named: icons[indexPath.row])

        let backgroundColorWhenSelected = UIView()
         backgroundColorWhenSelected.backgroundColor = UIColor.init(named: "mainColorAccentLight")
         cell.selectedBackgroundView = backgroundColorWhenSelected
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = items[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        cell.name.textColor = UIColor(named: "mainColor")
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        cell.name.textColor = UIColor(named: "accentLight")
    }
}


protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
