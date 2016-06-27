//
//  Post.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse
import Bond

class Post: PFObject, PFSubclassing {
    
    // MARK: - Properties
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    var image: Observable<UIImage?> = Observable(nil)
    var likes: Observable<[PFUser]?> = Observable(nil)
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    // MARK: - PFSubclassing Protocol
    static func parseClassName() -> String {
        return "Post"
    }
    
    // MARK: - Post Helper Methods
    func uploadPost() {
        
        if let image = image.value {
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {return}
            guard let imageFile = PFFile(name: "image.jpg", data: imageData) else {return}
            
            user = PFUser.currentUser()
            self.imageFile = imageFile
            
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            saveInBackgroundWithBlock() { (success: Bool, error: NSError?) in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }

        }
    }
    
    // MARK: - Image Helper Methods
    func downloadImage() {
        if (image.value == nil) {
            
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
                if let data = data {
                    let image = UIImage(data: data, scale:1.0)!
          
                    self.image.value = image
                }
            }
        }
    }
    
    // MARK: - Like Helper Methods
    func fetchLikes() {
        
        if (likes.value != nil) {
            return
        }
        
        ParseHelper.likesForPost(self, completionBlock: { (likes, error) in
        
            let validLikes = likes?.filter { like in like[ParseHelperConstants.LikeFromUser] != nil }
            
            // map replaces the objects
            self.likes.value = validLikes?.map { like in
                
                let fromUser = like[ParseHelperConstants.LikeFromUser] as! PFUser
                
                return fromUser
            }
        })
    }
    
    func doesUserLikePost(user: PFUser) -> Bool {
        if let likes = likes.value {
            return likes.contains(user)
        } else {
            return false
        }
    }
    
    func toggleLikePost(user: PFUser) {
        if (doesUserLikePost(user)) {
            // if post is liked, unlike it now
            likes.value = likes.value?.filter { $0 != user }
            ParseHelper.unlikePost(user, post: self)
        } else {
            // if this post is not liked yet, like it now
            likes.value?.append(user)
            ParseHelper.likePost(user, post: self)
        }
    }
    
}