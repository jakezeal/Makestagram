//
//  ParseHelper.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

class ParseHelper {
    
    // MARK: - Timeline
    static func timelineRequestForCurrentUser(completionBlock: PFQueryArrayResultBlock) {
        let followingQuery = PFQuery(className: ParseHelperConstants.FollowClass)
        followingQuery.whereKey(ParseHelperConstants.FollowFromUser, equalTo:PFUser.currentUser()!)
        
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey(ParseHelperConstants.PostUser, matchesKey: ParseHelperConstants.FollowToUser, inQuery: followingQuery)
        
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey(ParseHelperConstants.PostUser, equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        query.includeKey(ParseHelperConstants.PostUser)
        query.orderByDescending(ParseHelperConstants.PostCreatedAt)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    // MARK: - Likes
    static func likePost(user: PFUser, post: Post) {
        let likeObject = PFObject(className: ParseHelperConstants.LikeClass)
        likeObject[ParseHelperConstants.LikeFromUser] = user
        likeObject[ParseHelperConstants.LikeToPost] = post
        
        likeObject.saveInBackgroundWithBlock(nil)
    }
    
    static func unlikePost(user: PFUser, post: Post) {
        let query = PFQuery(className: ParseHelperConstants.LikeClass)
        query.whereKey(ParseHelperConstants.LikeFromUser, equalTo: user)
        query.whereKey(ParseHelperConstants.LikeToPost, equalTo: post)
        
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            if let results = results {
                for like in results {
                    like.deleteInBackgroundWithBlock(nil)
                }
            }
        }
    }
    
    static func likesForPost(post: Post, completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseHelperConstants.LikeClass)
        query.whereKey(ParseHelperConstants.LikeToPost, equalTo: post)
        query.includeKey(ParseHelperConstants.LikeFromUser)
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
}
