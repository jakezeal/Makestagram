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
    static func timelineRequestForCurrentUser(range: Range<Int>, completionBlock: PFQueryArrayResultBlock) {
        let followingQuery = PFQuery(className: ParseHelperConstants.FollowClass)
        followingQuery.whereKey(ParseHelperConstants.FollowFromUser, equalTo:PFUser.currentUser()!)
        
        let postsFromFollowedUsers = Post.query()
        postsFromFollowedUsers!.whereKey(ParseHelperConstants.PostUser, matchesKey: ParseHelperConstants.FollowToUser, inQuery: followingQuery)
        
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey(ParseHelperConstants.PostUser, equalTo: PFUser.currentUser()!)
        
        let query = PFQuery.orQueryWithSubqueries([postsFromFollowedUsers!, postsFromThisUser!])
        query.includeKey(ParseHelperConstants.PostUser)
        query.orderByDescending(ParseHelperConstants.PostCreatedAt)
        
        query.skip = range.startIndex
        query.limit = range.endIndex - range.startIndex
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    // MARK: - Likes
    static func likePost(user: PFUser, post: Post) {
        let likeObject = PFObject(className: ParseHelperConstants.LikeClass)
        likeObject[ParseHelperConstants.LikeFromUser] = user
        likeObject[ParseHelperConstants.LikeToPost] = post
        
        likeObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    static func unlikePost(user: PFUser, post: Post) {
        let query = PFQuery(className: ParseHelperConstants.LikeClass)
        query.whereKey(ParseHelperConstants.LikeFromUser, equalTo: user)
        query.whereKey(ParseHelperConstants.LikeToPost, equalTo: post)
        
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            }
            
            if let results = results {
                for like in results {
                    like.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
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
    
    // MARK: - Following
    /**
     Fetches all users that the provided user is following.
     
     - parameter user:            The user whose followees you want to retrieve
     - parameter completionBlock: The completion block that is called when the query completes
     */
    static func getFollowingUsersForUser(user: PFUser, completionBlock: PFQueryArrayResultBlock) {
        let query = PFQuery(className: ParseHelperConstants.FollowClass)
        
        query.whereKey(ParseHelperConstants.FollowFromUser, equalTo:user)
        query.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    /**
     Establishes a follow relationship between two users.
     
     - parameter user:   The user that is following
     - parameter toUser: The user that is being followed
     */
    static func addFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let followObject = PFObject(className: ParseHelperConstants.FollowClass)
        followObject.setObject(user, forKey: ParseHelperConstants.FollowFromUser)
        followObject.setObject(toUser, forKey: ParseHelperConstants.FollowToUser)
        
        followObject.saveInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
    }
    
    /**
     Deletes a follow relationship between two users.
     
     - parameter user:   The user that is following
     - parameter toUser: The user that is being followed
     */
    static func removeFollowRelationshipFromUser(user: PFUser, toUser: PFUser) {
        let query = PFQuery(className: ParseHelperConstants.FollowClass)
        query.whereKey(ParseHelperConstants.FollowFromUser, equalTo:user)
        query.whereKey(ParseHelperConstants.FollowToUser, equalTo: toUser)
        
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) in
            
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            }
            
            let results = results ?? []
            
            for follow in results {
                follow.deleteInBackgroundWithBlock(ErrorHandling.errorHandlingCallback)
            }
        }
    }
    
    // MARK: Users
    /**
     Fetch all users, except the one that's currently signed in.
     Limits the amount of users returned to 20.
     
     - parameter completionBlock: The completion block that is called when the query completes
     
     - returns: The generated PFQuery
     */
    static func allUsers(completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        let query = PFUser.query()!
        // exclude the current user
        query.whereKey(ParseHelperConstants.UserUsername,
                       notEqualTo: PFUser.currentUser()!.username!)
        query.orderByAscending(ParseHelperConstants.UserUsername)
        query.limit = 100
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    
    /**
     Fetch users whose usernames match the provided search term.
     
     - parameter searchText:      The text that should be used to search for users
     - parameter completionBlock: The completion block that is called when the query completes
     
     - returns: The generated PFQuery
     */
    static func searchUsers(searchText: String, completionBlock: PFQueryArrayResultBlock) -> PFQuery {
        /*
         NOTE: We are using a Regex to allow for a case insensitive compare of usernames.
         Regex can be slow on large datasets. For large amount of data it's better to store
         lowercased username in a separate column and perform a regular string compare.
         */
        let query = PFUser.query()!.whereKey(ParseHelperConstants.UserUsername,
                                             matchesRegex: searchText, modifiers: "i")
        
        query.whereKey(ParseHelperConstants.UserUsername,
                       notEqualTo: PFUser.currentUser()!.username!)
        
        query.orderByAscending(ParseHelperConstants.UserUsername)
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock(completionBlock)
        
        return query
    }
    
}

// MARK: - Extensions
extension PFObject {
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if (object as? PFObject)?.objectId == self.objectId {
            return true
        } else {
            return super.isEqual(object)
        }
    }
    
}