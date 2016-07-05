//
//  Constants.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import ConvenienceKit

// MARK: - Parse Helper Constants
struct ParseHelperConstants {
    // Following Relation
    static let FollowClass       = "Follow"
    static let FollowFromUser    = "fromUser"
    static let FollowToUser      = "toUser"
    
    // Like Relation
    static let LikeClass         = "Like"
    static let LikeToPost        = "toPost"
    static let LikeFromUser      = "fromUser"
    
    // Post Relation
    static let PostUser          = "user"
    static let PostCreatedAt     = "createdAt"
    
    // Flagged Content Relation
    static let FlaggedContentClass    = "FlaggedContent"
    static let FlaggedContentFromUser = "fromUser"
    static let FlaggedContentToPost   = "toPost"
    
    // User Relation
    static let UserUsername      = "username"
}

// MARK: - Identifier Constants
struct IdentifierConstants {
    static let PostCellIdentifier = "PostCell"
    static let FriendSearchCellIdentifier = "UserCell"
}

// MARK: - Error Handling Constants
struct ErrorHandling {
    
    static let ErrorTitle           = "Error"
    static let ErrorOKButtonTitle   = "Ok"
    static let ErrorDefaultMessage  = "Something unexpected happened, sorry for that!"
    
    
    // This default error handler presents an Alert View on the topmost View Controller
    static func defaultErrorHandler(error: NSError) {
        let alert = UIAlertController(title: ErrorTitle, message: ErrorDefaultMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: ErrorOKButtonTitle, style: .Default, handler: nil))
        
        let window = UIApplication.sharedApplication().windows[0]
        window.rootViewController?.presentViewControllerFromTopViewController(alert, animated: true, completion: nil)
    }
    
    // A PFBooleanResult callback block that only handles error cases. You can pass this to completion blocks of Parse Requests
    static func errorHandlingCallback(success: Bool, error: NSError?) -> Void {
        if let error = error {
            ErrorHandling.defaultErrorHandler(error)
        }
    }
    
}