//
//  SignupViewController.swift
//  Makestagram
//
//  Created by Jake on 2015-05-27.
//  Copyright (c) 2016 Jake Zeal. All rights reserved.
//

import UIKit

class SignupViewController : UIViewController, UITextFieldDelegate {

    // MARK:- IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
        
    // MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    // MARK:- Preparations
    
    // MARK:- IBActions
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
    }
    
    /**
     @name  prefersStatusBarHidden
     
     - returns: Bool
     */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
