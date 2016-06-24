//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Jake on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    // MARK: - Properties
    var photoTakingHelper: PhotoTakingHelper?
    
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBarController()
        
    }
    
    // MARK: - Preparations
    func prepareTabBarController() {
        tabBarController?.delegate = self
    }
    
    // MARK: - Helpers
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: tabBarController!) { (image: UIImage?) in
            //
        }
    }
}

// MARK: - Tab Bar Controller Delegate
extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
}