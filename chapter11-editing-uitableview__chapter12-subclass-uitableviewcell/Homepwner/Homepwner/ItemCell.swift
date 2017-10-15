//
//  ItemCell.swift
//  Homepwner
//
//  Created by Christopher Lee on 15/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    // Bronze Challenge
    var isUnderFifty: Bool = false {
        didSet {
            valueLabel.textColor = isUnderFifty ? UIColor.green : UIColor.red
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        serialNumberLabel.adjustsFontForContentSizeCategory = true
        valueLabel.adjustsFontForContentSizeCategory = true
    }
}
