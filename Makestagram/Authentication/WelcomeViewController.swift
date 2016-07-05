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
        prepareImageViewShakeAnimation()
        prepareRotateImageViewAnimation()
//        prepareButtonShake()
    }
    
    // MARK:- Preparations
    func prepareNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func prepareTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(WelcomeViewController.shake))
        imageView.addGestureRecognizer(tap)
    }
    
    func prepareImageViewShakeAnimation() {
            imageViewShakeAnimation = CustomAnimation(view: imageView, delay: 0.1, direction: .Left, repetitions: 7, maxRotation: 0.2, maxPosition: 100, duration: 0.2)
    }
    
    func prepareRotateImageViewAnimation() {
        imageViewRotateAnimation = CustomAnimation(view: imageView, delay: 0, direction: .Left, repetitions: 4, maxRotation: 4, maxPosition: 0, duration: 1)
    }
    
    // MARK:- Actions
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
    }
    
    // MARK: - Helper Methods
    func shake() {
//        imageViewShakeAnimation.shakeAnimation()
        imageViewRotateAnimation.rotateAnimation()
//        imageViewShakeAnimation.flyIn()
//        imageViewShakeAnimation.shakeAnimation()
//        imageViewShakeAnimation.spinAnimation()
//        buttonShake.shakeAnimation()
    }
}


