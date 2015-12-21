//
//  CustomHeader.swift
//  TwitterCF
//
//  Created by William Cremin on 10/30/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

import UIKit

class CustomHeader: UITableViewCell {
    
    @IBOutlet weak var headerProfileImageView: UIImageView!
    @IBOutlet weak var headerUserNameLabel: UILabel!
    @IBOutlet weak var headerUserLocationLabel: UILabel!
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    
    class func identifier() -> String {
        return "CustomTableViewHeader"
    }
    
    var currentUser: User? {
        didSet {
            self.headerUserNameLabel.text = self.currentUser!.name
            self.headerUserLocationLabel.text = self.currentUser!.location
            self.headerProfileImageView.image = self.currentUser!.image
            
            if let backgroundUser = self.currentUser {
                if let url = NSURL(string: backgroundUser.backgroundUrl) {
                    let downloadQ = dispatch_queue_create("bgDownloadQ", nil)
                    dispatch_async(downloadQ, { () -> Void in
                        if let imageData = NSData(contentsOfURL: url) {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let bgImage = UIImage(data: imageData)
                                self.headerBackgroundImageView.image = bgImage
                            })
                        } else {
                            return
                        }
                    })
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
