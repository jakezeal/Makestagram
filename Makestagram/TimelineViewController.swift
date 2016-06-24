//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Jake on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBarController()
        
    }
    
    // MARK: - Preparations
    func prepareTabBarController() {
        tabBarController?.delegate = self
    }
}

// MARK: - Tab Bar Controller Delegate
extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            print("Take Photo")
            return false
        } else {
            return true
        }
    }
}