//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Christopher Lee on 15/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "More than $50"
        default:
            return "Others"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemStore.highValueItems.count
        default:
            return itemStore.lowValueItems.count + 1   // 1 for "No more items!"
        }
    }
    
    // Gold Challenge
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == itemStore.lowValueItems.count {
            return 44
        } else {
            return 60
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let items: [Item]
        
        switch indexPath.section {
        case 0:
            items = itemStore.highValueItems
        default:
            items = itemStore.lowValueItems
        }
        
        if indexPath.section == 1 && indexPath.row == items.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
        } else {
            let item = items[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "\(item.valueInDollars)"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        
        return cell
    }
}
