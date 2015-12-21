//
//  TweetDetailViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/28/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet: Tweet!
    

    @IBOutlet weak var userProfileImage: UIButton!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    class func identifier() -> String {
        return "tweetDetailViewController"
    }
    
    private lazy var detailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        label.text = "Created by Cynthia"
        label.textColor = UIColor.blackColor()
        return label
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setupAppearance()
//        self.setupTweetDetailViewController()
        
        if tweet.isRetweet != nil {
            self.title = "@\(tweet.isRetweet!.user!.screenName)"
            tweetLabel.text = tweet.isRetweet?.text
            userLabel.text = tweet.isRetweet?.user?.name
            userProfileImage.setImage(tweet.isRetweet?.user?.image, forState: .Normal)
        } else {
            self.title = "@\(tweet.user!.screenName)"
            tweetLabel.text = tweet.text
            userLabel.text = tweet.user?.name
            userProfileImage.setImage(tweet.user?.image, forState: .Normal)
        }
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.detailLabel)
        
        
        let centerX = NSLayoutConstraint(item: self.detailLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: self.detailLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -20.0)
        
        centerX.active = true
        bottom.active = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == UserTimelineViewController.identifier() {
            if let destination = segue.destinationViewController as? UserTimelineViewController {
                if tweet.isRetweet != nil {
                    destination.currentUser = self.tweet.isRetweet?.user
                } else {
                    destination.currentUser = self.tweet.user
                    
                }
            }
        }
    }
}







