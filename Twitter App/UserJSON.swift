//
//  UserJSON.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class UserJSON {
    
    class func userFromJSONData(json: NSData) -> [Tweet]? {
        
        do {
            
            // Can user successfully translate the JSON data
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                                
                //create / initialize an array
                var tweets = [Tweet]()
                
                //enumerate through the array
                for tweetObject in rootObject {
                    if let text = tweetObject["text"] as? String, id = tweetObject["id_str"] as? String, user = tweetObject["user"] as? [String : AnyObject] {
                        let tweet = Tweet(text: text, id: id)
                        if let name = user["name"] as? String, screenName =
                            user["screen_name"] as? String, profileImageUrl =
                            user["profile_image_url_https"] as? String, location =
                            user["location"] as? String, backgroundUrl =
                            user["profile_banner_url"] as? String {
                                tweet.user = User(name: name, profileImageURL: profileImageUrl, screenName: screenName, backgroundUrl: backgroundUrl, location: location)
                        }
                        
                        tweets.append(tweet)
                        if let retweet = tweetObject["retweeted_status"] as? [String : AnyObject] {
                            if let retweetedText = retweet["text"] as? String, retweetedId = retweet["id_str"] as? String, retweetedUser = retweet["user"] as? [String : AnyObject] {
                                tweet.isRetweet = Tweet(text: retweetedText, id: retweetedId)
                                if let retweetedName =
                                    retweetedUser["name"] as? String, retweetedScreenName =
                                    retweetedUser["screen_name"] as? String, profileImageUrl =
                                    retweetedUser["profile_image_url_https"] as? String, location =
                                    retweetedUser["location"] as? String, backgroundUrl =
                                    retweetedUser["profile_banner_url"] as? String {
                                        tweet.isRetweet?.user = User(name: retweetedName, profileImageURL: profileImageUrl, screenName: retweetedScreenName, backgroundUrl: backgroundUrl, location: location)
                                }
                            }
                        }
                    }
                }
                return tweets
            }
            
        } catch _ {
            
            let alert = UIAlertController(title: "Error", message: "There was an Error", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            alert.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        return nil
    }
}

    func userFromData(user: [String : AnyObject]) -> User? {
    if let name = user["name"] as? String, screenName = user["screen_name"] as? String, profileImageUrl = user["profile_image_url_https"] as? String, backgroundUrl = user["profile_background_image_url_https"] as? String, location = user["location"] as? String {
        return User(name: name, profileImageURL: profileImageUrl, screenName: screenName, backgroundUrl: backgroundUrl, location: location)
    }
    return nil
}

