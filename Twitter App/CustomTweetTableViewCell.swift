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
            
            self.customTweetLabel.text = self.tweet!.text
//            self.customCellImage.image = UIImage(named: "ganesh.jpg")
            
            if let tweet = self.tweet, user = tweet.user {
                
                if let url = NSURL(string: "ganesh.jpg") {
                    
                
                let downloadQ = dispatch_queue_create("downloadQ", nil)
                dispatch_async(downloadQ, { () -> Void in
                    let imageData = NSData(contentsOfURL: url)
                    
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.customCellImage.image = UIImage(data: imageData!)
                    
                })
                })
                
                    
//                    NSOperationQueue().addOperationWithBlock({ () -> Void in
//                        let imageData = NSData(contentsOfURL: url)!
//                        self.customCellImage.image = UIImage(data: imageData)
//                        
//                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                        self.customCellImage.image = UIImage(data: imageData)
//                        })
//                    })
                    


                }
                
                
                    if let image = user.image {
                        self.customCellImage.image = image

                }
            }
        }
    }
    
    class func identifier() -> String {
        return "tweetCustomTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
