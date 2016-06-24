//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Jake on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {


    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
