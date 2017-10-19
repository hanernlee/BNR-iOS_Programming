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
    
    var selectedLineIndex: Int?
    
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Double Tap to clear
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawView.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        // Select line
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawView.tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc func doubleTap(_ gestureRecognizer: UIGestureRecognizer) {
        print("Recognized double tap")
        
        selectedLineIndex = nil
        currentLines.removeAll()
        finishedLines.removeAll()
        
        finishedCircles.removeAll()
        
        setNeedsDisplay()
    }
    
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer) {
        print("Recognized a tap")
        
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = indexOfLine(at: point)
        
        setNeedsDisplay()
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
        finishedLineColor.setStroke()
        for line in finishedLines {
            line.color.setStroke()    // Use color by angle
            stroke(line)
        }

        currentLineColor.setStroke()
        for (_ , line) in currentLines {
            line.color.setStroke()    // Use color by angle
            stroke(line)
        }
        
        if let index = selectedLineIndex {
            UIColor.green.setStroke()
            let selectedLine = finishedLines[index]
            stroke(selectedLine)
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
    
    func indexOfLine(at point: CGPoint) -> Int? {
        // Find a line close to the point
        for (index, line) in finishedLines.enumerated() {
            let begin = line.begin
            let end = line.end
            
            // Check few points on a line
            for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                // If tapped point is within 20 points, let's return this line
                if (hypot(x - point.x, y - point.y) < 20.0) {
                    return index
                }
            }
        }
        // If nothing is close enough to the tapped point , then we did not select a line
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
