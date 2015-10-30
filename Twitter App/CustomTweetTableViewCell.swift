//
//  CustomTweetTableViewCell.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/29/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class CustomTweetTableViewCell: UITableViewCell {

    @IBOutlet weak var customCellImage: UIImageView!
    @IBOutlet weak var customTweetLabel: UILabel!
    
    var tweet : Tweet? {
        
        didSet {
            if let tweet = self.tweet,
            user = tweet.user,
            text = self.tweet?.text {
                
            self.customTweetLabel.text = text
                
                if let image = user.image {
                    self.customCellImage.image = image
                    
                } else {
                    
                    if let url = NSURL(string:user.profileManagerURL) {
                        let downloadQ = dispatch_queue_create("downloadQ", nil)                    }
                }
                    
            }
        }
        
        
    }
    
    class func identifier() -> String {
        return "tweetCustomTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
