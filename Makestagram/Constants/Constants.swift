//
//  Constants.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

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

// MARK:- Identifier Constants
struct IdentifierConstants {
    static let postCellIdentifier = "PostCell"
}