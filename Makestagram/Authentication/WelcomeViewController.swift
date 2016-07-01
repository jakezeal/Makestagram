//
//  WelcomeViewController.swift
//  Makestagram
//
//  Created by Jake on 2015-05-27.
//  Copyright (c) 2016 Jake Zeal. All rights reserved.
//

import UIKit

class WelcomeViewController : UIViewController {
    
    // MARK:- Properties
    let titleLabel: UILabel = UILabel()
    var imageViewShakeAnimation: CustomAnimation!
    var imageViewRotateAnimation: CustomAnimation!
    var buttonShake: CustomAnimation!
    
    // MARK:- Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar()
        prepareTapGestureRecognizer()
        prepareImageView()
        prepareImageViewShakeAnimation()
        prepareRotateImageViewAnimation()
//        prepareButtonShake()
    }
    
    // MARK:- Preparations
    func prepareNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }
    
    func prepareTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.shake))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tap)
//        loginButton.addGestureRecognizer(tap)
    }
    
    func prepareImageView() {
        //        imageView.roundCorners()
        
    }
    
    func prepareImageViewShakeAnimation() {
            imageViewShakeAnimation = CustomAnimation(view: imageView, delay: 0.1, direction: .Left, repetitions: 7, maxRotation: 0.2, maxPosition: 100, duration: 0.2)
    }
    
    func prepareRotateImageViewAnimation() {
        imageViewRotateAnimation = CustomAnimation(view: imageView, delay: 0, direction: .Left, repetitions: 4, maxRotation: 2, maxPosition: 100, duration: 0.2)
    }
    
//    func prepareButtonShake() {
//        buttonShake = CustomAnimation(view: loginButton, delay: 0.1, direction: .Right, repetitions: 7, maxRotation: 0.2, maxPosition: 50, duration: 0.2)
//    }
    
    // MARK:- Actions
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
    }
    
    // MARK: - Helper Methods
    func shake() {
        imageViewRotateAnimation.rotateAnimation()
//        imageViewShakeAnimation.flyIn()
//        imageViewShakeAnimation.shakeAnimation()
//        imageViewShakeAnimation.rotate360Degrees()
//        imageViewShakeAnimation.spinAnimation()
//        buttonShake.shakeAnimation()
    }
    
    // MARK: - Delegate Methods
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}


