//
//  ParseLoginHelper.swift
//  Makestagram
//
//  Created by Jake on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

typealias ParseLoginHelperCallback = (PFUser?, NSError?) -> Void

/**
 This class implements the 'PFLogInViewControllerDelegate' protocol. After a successfull login
 it will call the callback function and provide a 'PFUser' object.
 */
class ParseLoginHelper : NSObject {
    static let errorDomain = "com.makeschool.parseloginhelpererrordomain"
    static let usernameNotFoundErrorCode = 1
    static let usernameNotFoundLocalizedDescription = "Could not retrieve Facebook username"
    
    let callback: ParseLoginHelperCallback
    
    init(callback: ParseLoginHelperCallback) {
        self.callback = callback
    }
}

