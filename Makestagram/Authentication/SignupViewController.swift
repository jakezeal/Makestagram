//
//  SignupViewController.swift
//  Makestagram
//
//  Created by Jake on 2015-05-27.
//  Copyright (c) 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Parse

class SignupViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var usernameShake: CustomAnimation!
    var passwordShake: CustomAnimation!
    var emailShake: CustomAnimation!
    
    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUsernameShake()
        preparePasswordShake()
        prepareEmailShake()
    }
    
    // MARK: - Preparations
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func prepareUsernameShake() {
        usernameShake = CustomAnimation(view: usernameTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    func preparePasswordShake() {
        passwordShake = CustomAnimation(view: passwordTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    func prepareEmailShake() {
        emailShake = CustomAnimation(view: emailTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        // if textfields aren't empty and have more than 6 characters
        
        if username.characters.count > 3 && password.characters.count > 3 && email.containsString("@") {
            let user = PFUser()
            user.username = username
            user.password = password
            user.email = email
            
            user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
                // set current user and switch to tab controller
                //                PFUser.currentUser()
                NSNotificationCenter.defaultCenter().postNotificationName("Login", object: nil)
            }
            
        } else {
            usernameShake.shakeAnimation()
            passwordShake.shakeAnimation()
            emailShake.shakeAnimation()
        }
    }
}
