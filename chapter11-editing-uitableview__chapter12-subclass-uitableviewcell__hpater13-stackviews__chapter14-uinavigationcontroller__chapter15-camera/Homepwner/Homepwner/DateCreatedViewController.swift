//
//  DateCreatedViewController.swift
//  Homepwner
//
//  Created by Christopher Lee on 16/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class DateCreatedViewController: UIViewController {
    var datePicker: UIDatePicker!
    var item: Item!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Date Created"
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}
