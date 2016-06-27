//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var postDisposable: DisposableType?
    var likeDisposable: DisposableType?
    var post: Post? {
        didSet {
            
            postDisposable?.dispose()
            likeDisposable?.dispose()
            
            if let post = post {
                
                postDisposable = post.image.bindTo(postImageView.bnd_image)
                likeDisposable = post.likes.observe { (value: [PFUser]?) -> () in
                    
                    if let value = value {
                        
                        self.likesLabel.text = self.stringFromUserList(value)
                        self.likeButton.selected = value.contains(PFUser.currentUser()!)
                        self.likesIconImageView.hidden = (value.count == 0)
                        
                    } else {
                        self.likesLabel.text = ""
                        self.likeButton.selected = false
                        self.likesIconImageView.hidden = true
                    }
                }
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
    }
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
        
    }
    
    // MARK: - Helper Methods
    func stringFromUserList(userList: [PFUser]) -> String {
        
        let usernameList = userList.map { user in user.username! }
        let commaSeparatedUserList = usernameList.joinWithSeparator(", ")
        
        return commaSeparatedUserList
    }
    
}
