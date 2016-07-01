//
//  CustomAnimation.swift
//  Makestagram
//
//  Created by Jake on 6/29/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

enum State {
    case First
    case Middle
    case Final
}

class CustomAnimation {
    
    // MARK: - Properties
    var view: UIView!
    var delay: Double!
    var repetitions: Int!
    var maxRotation: CGFloat!
    var maxPosition: CGFloat!
    var duration: Double!
    
    var running = false
    
    var direction: Direction = .Left
    
    var state: State = .First
    
    var counter = 0
    
    // MARK: - Initializers
    init(view: UIView, delay: Double, direction: Direction, repetitions: Int, maxRotation: CGFloat, maxPosition: CGFloat, duration: Double) {
        self.view = view
        self.delay = delay
        self.direction = direction
        self.repetitions = repetitions
        self.maxRotation = maxRotation
        self.maxPosition = maxPosition
        self.duration = duration
    }
    
    // MARK: - Animation Methods
    func rotateAnimation() {
        let factor = CGFloat(self.direction.rawValue * 2 - 1)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        
        // Rotate to the Right
        rotateAnimation.toValue = CGFloat(M_PI * Double(self.maxRotation) * 2.0)
        
        // Rotate to the Left
        //        rotateAnimation.toValue = CGFloat(M_PI * 4.0 * Double(factor))
        
        rotateAnimation.duration = 2
        self.view.layer.addAnimation(rotateAnimation, forKey: nil)
        
        self.maxRotation = self.maxRotation * factor
    }
    
    
    func shakeAnimation() {
        
        guard running else {
            running = true
            
            UIView.animateWithDuration(self.duration, delay: self.delay, options: .TransitionNone, animations: {
                
                var position = self.maxPosition
                var rotation = self.maxRotation
                
                switch self.state {
                case .First:
                    position = self.maxPosition / 2
                    break
                case .Middle:
                    break
                case .Final:
                    rotation = 0
                    position = self.maxPosition / 2
                    break
                }
                
                let factor = CGFloat(self.direction.rawValue * 2 - 1)
                
                // Position
                let x = self.view.center.x + position * factor
                self.view.layer.position.x = x
                
                // Rotation
                self.view.transform = CGAffineTransformMakeRotation(rotation * factor)
                
            }) { (completed: Bool) in
                self.running = false
                self.finishAnimation()
            }
            return
        }
            
        
    }
    
    func flyIn() {
        
        //        UIView.animateWithDuration(self.duration, delay: self.delay, options: .CurveEaseIn, animations: {
        //
        //            let x = self.view.center.x + self.maxPosition * self.factor
        //            self.view.layer.position.x = x
        //
        //        }) { (completed: Bool) in
        //
        //            for self.counter in 0...3 {
        //                self.counter += 1
        //                self.flyIn()
        //            }
        //        }
        
    }   
    
}

private extension CustomAnimation {
    // MARK: - Private Helper Methods
    func finishAnimation() {
        self.direction = Direction(rawValue: abs(self.direction.rawValue - 1))!
        
        if self.counter < self.repetitions {
            self.state = .Middle
            self.shakeAnimation()
            self.counter += 1
            
        } else if self.counter == self.repetitions {
            self.state = .Final
            self.shakeAnimation()
            self.counter += 1
            
        } else {
            self.state = .First
            self.counter = 0
            
            if self.repetitions % 2 == 0 {
                self.direction = Direction(rawValue: abs(self.direction.rawValue - 1))!
            }
        }
        
    }
}
