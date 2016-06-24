//
//  Post.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    
    // MARK: - Properties
    var image: UIImage?
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
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
    
    // MARK: - Helper Methods
    func uploadPost() {
        
        if let image = image {
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
    
}