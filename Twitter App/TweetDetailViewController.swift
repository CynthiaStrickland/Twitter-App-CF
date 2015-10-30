//
//  TweetDetailViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/28/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet: Tweet?
    
    class func identifier() -> String {
        return "TweetDetailViewController"
    }
    
    class func isRetweet(tweetObject: [String : AnyObject]) -> (Bool, [String : AnyObject]?) {
        if let retweetObjectObject = tweetObject["retweeted_status"] as? [String : AnyObject] {
            if let _ = retweetObjectObject {
            
            
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tweet = self.tweet {
            print(tweet.text)
        }
    }
    


}
