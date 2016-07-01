//
//  PostSectionHeaderView.swift
//  Makestagram
//
//  Created by Jake on 7/1/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import DateTools

class PostSectionHeaderView: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    // MARK: - Properties
    var post: Post? {
        didSet {
            if let post = post {
                usernameLabel.text = post.user?.username
                postTimeLabel.text = post.createdAt?.shortTimeAgoSinceDate(NSDate()) ?? ""
            }
        }
    }
    
}
