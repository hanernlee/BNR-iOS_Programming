//
//  CustomTextField.swift
//  Homepwner
//
//  Created by Christopher Lee on 16/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        borderStyle = .bezel
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        borderStyle = .roundedRect
        return super.resignFirstResponder()
    }
}
