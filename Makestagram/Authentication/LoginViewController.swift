//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Jake on 2015-05-27.
//  Copyright (c) 2016 Jake Zeal. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    func didPressLoginButton()
}

class LoginViewController : UIViewController, UITextFieldDelegate {
    
    // MARK:- Properties
    var delegate: LoginViewControllerDelegate?
    
    // MARK:- Outlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK:- Preparations
    
    // MARK: - IBActions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("Login", object: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Delegate Methods
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}