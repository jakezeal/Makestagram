//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Jake on 6/23/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {
    
    // MARK: - Properties
    var posts: [Post] = []
    
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTabBarController()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ParseHelper.timelineRequestForCurrentUser { (result: [PFObject]?, error: NSError?) in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Preparations
    func prepareTabBarController() {
        tabBarController?.delegate = self
    }
    
    // MARK: - Helpers
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo is selected
        photoTakingHelper = PhotoTakingHelper(viewController: tabBarController!) { (image: UIImage?) in
            
            let post = Post()
            post.image.value = image!
            post.uploadPost()
            
        }
    }    
}

// MARK: - Tab Bar Controller Delegate
extension TimelineViewController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
}

// MARK: - Table View Data Source Extension
extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(IdentifierConstants.postCellIdentifier)! as! PostTableViewCell
        
        let post = posts[indexPath.row]
        post.downloadImage()
        cell.post = post
        
        return cell
    }
}


