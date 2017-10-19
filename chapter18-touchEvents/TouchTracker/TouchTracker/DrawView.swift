//
//  DrawView.swift
//  TouchTracker
//
//  Created by Christopher Lee on 19/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    var currentCircle = Circle()
    var finishedCircles = [Circle]()
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // Draw finished lines in black
//        UIColor.black.setStroke()
        finishedLineColor.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
//        if let line = currentLine {
//            // If there is a line currently being drawn, do it in red
//            UIColor.red.setStroke()
//            stroke(line)
//        }
        
        // Draw currentLines in red
//        UIColor.red.setStroke()
        currentLineColor.setStroke()
        for (_ , line) in currentLines {
            stroke(line)
        }
        
        // Draw Circles
        finishedLineColor.setStroke()
        for circle in finishedCircles {
            let path = UIBezierPath(ovalIn: circle.rect)
            path.lineWidth = lineThickness
            path.stroke()
        }
        currentLineColor.setStroke()
        UIBezierPath(ovalIn: currentCircle.rect).stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
        // Get location of touch in view's coordinate system
//        let location = touch.location(in: self)
//        currentLine = Line(begin: location, end: location)
        
        // Log statement to see the order of events
        print(#function)
        
        if touches.count == 2 {
            let touchesArray = Array(touches)
            let location1 = touchesArray[0].location(in: self)
            let location2 = touchesArray[1].location(in: self)
            currentCircle = Circle(point1: location1, point2: location2)
        } else {
            for touch in touches {
                let location = touch.location(in: self)
                let newLine = Line(begin: location, end: location)
                
                let key = NSValue(nonretainedObject: touch)
                currentLines[key] = newLine
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        currentLine?.end = location
        
        // Log statement to see order of events
        print(#function)
        
        if touches.count == 2 {
            let touchesArray = Array(touches)
            let location1 = touchesArray[0].location(in: self)
            let location2 = touchesArray[1].location(in: self)
            currentCircle = Circle(point1: location1, point2: location2)
        } else {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                currentLines[key]?.end = touch.location(in: self)
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if var line = currentLine {
//            let touch = touches.first!
//            let location = touch.location(in: self)
//            line.end = location
//
//            finishedLines.append(line)
//        }
//        currentLine = nil
        
        // Log statement to see order of events
        print(#function)
        
        if touches.count == 2 {
            let touchesArray = Array(touches)
            let location1 = touchesArray[0].location(in: self)
            let location2 = touchesArray[1].location(in: self)
            currentCircle = Circle(point1: location1, point2: location2)
            finishedCircles.append(currentCircle)
            currentCircle = Circle()
        } else {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                
                if var line = currentLines[key] {
                    line.end = touch.location(in: self)
                    
                    finishedLines.append(line)
                    currentLines.removeValue(forKey: key)
                }
            }
        }
        
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Log statement to see order of events
        print(#function)
        
        currentLines.removeAll()
        currentCircle = Circle()
        
        setNeedsDisplay()
    }
}
