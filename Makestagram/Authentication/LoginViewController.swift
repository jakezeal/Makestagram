//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Jake on 2015-05-27.
//  Copyright (c) 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController : UIViewController, UITextFieldDelegate {
    
    // MARK:- Properties
    var passwordShake: CustomAnimation!
    
    // MARK:- Outlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePasswordShake()
    }
    
    // MARK: - Preparations
    func preparePasswordShake() {
        passwordShake = CustomAnimation(view: passwordTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 20, duration: 0.1)
    }

    
    // MARK:- Preparations
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // If password incorrect

//        let query = PFQuery()
//        query.whereKey("username", equalTo: username)
//        query.whereKey("password", equalTo: password)
        
        PFUser.logInWithUsernameInBackground(username, password: password)
        
        
//            PFUser.currentUser()
//            NSNotificationCenter.defaultCenter().postNotificationName("Login", object: nil)
//        } else {
//            passwordShake.shakeAnimation()
//        }
        
        
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }    
}