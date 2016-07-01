//
//  AppDelegate.swift
//  Makestagram
//
//  Created by Benjamin Encz on 5/15/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var welcomeViewController: WelcomeViewController!
    
    
    var parseLoginHelper: ParseLoginHelper!
    
    var startViewController: UIViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        prepareInitialViewController()
        prepareWindow()
        prepareParse()
        return true
        
    }
    
    // MARK: - Preparations
    func prepareWindow() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = startViewController
        self.window?.makeKeyAndVisible()
    }
    
    func prepareInitialViewController() {
        let user = PFUser.currentUser()
        
        if (user != nil) {
            // if we have a user, set the TabBarController to be the initial view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            startViewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        } else {
            // Otherwise set the WelcomeNavigationController to be the initial view controller
            let storyboard = UIStoryboard(name: "SignupLogin", bundle: nil)
            startViewController = storyboard.instantiateViewControllerWithIdentifier("WelcomeNavigationController") as! UINavigationController
        }
    }
    
    func prepareParseLoginHelper() {
        parseLoginHelper = ParseLoginHelper {[unowned self] user, error in
            // Initialize the ParseLoginHelper with a callback
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            } else  if let _ = user {
                // if login was successful, display the TabBarController
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
                self.window?.rootViewController!.presentViewController(tabBarController, animated:true, completion:nil)
            }
        }
    }
    
    func prepareParse() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "makestagramjake"
            $0.server = "https://makestagram-jake-server.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
        let acl = PFACL()
        acl.publicReadAccess = true
        PFACL.setDefaultACL(acl, withAccessForCurrentUser: true)
    }
}


