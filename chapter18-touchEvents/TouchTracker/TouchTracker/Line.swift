//
//  Line.swift
//  TouchTracker
//
//  Created by Christopher Lee on 18/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import CoreGraphics

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
}

extension Line {
    var angleDegree : CGFloat {
        
        guard begin != end else { return 0 }
        
        let dX = end.x - begin.x
        let dY = end.y - begin.y
        
        var angle = atan2(dY, dX) * 180 / CGFloat(Double.pi)
        
        //make negative angles be positive and angles can go from 0 to 360
        if angle < 0 {
            angle = angle + 360
        }
        print(angle)
        return CGFloat(angle)
        
    }
    
    var color: UIColor {
        let hueCode = angleDegree / 360
        
        return UIColor(hue: hueCode, saturation: 1, brightness: 1, alpha: 0.6)
    }
}
