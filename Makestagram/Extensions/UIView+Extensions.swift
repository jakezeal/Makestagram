//
//  UIView+Shadow.swift
//  Makestagram
//
//  Created by Jake on 5/9/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSizeMake(3, 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
    }
    
    func roundCorners() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}
