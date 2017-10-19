//
//  Circle.swift
//  TouchTracker
//
//  Created by Christopher Lee on 19/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import CoreGraphics


struct Circle {
    var rect = CGRect.zero
    
    init() {
        self.rect = CGRect.zero
    }
    
    init(rect: CGRect) {
        self.rect = rect
    }
    
    init(point1: CGPoint, point2: CGPoint) {
        let width = abs(point2.x - point1.x)
        let height = abs(point2.y - point1.y)
        let diameter = min(width, height)
        let radius = diameter / 2
        let center = CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
        self.rect = CGRect(x: center.x - radius, y: center.y - radius, width: diameter, height: diameter)
    }
}
