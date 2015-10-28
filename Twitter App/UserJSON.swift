//
//  UserJSON.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class UserJSON {
    
    class func userFromJSONData(json: NSData) -> [User]? {
        
        do {
            
            // Can user successfully translate the JSON data
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                
                print(rootObject)
                
                //create / initialize an array
                var tweets = [User]()
                
                //enumerate through the array
                for tweetObject in rootObject {
                    //if it has values
                    if let
                        
                        userInfo = tweetObject["user"] as? [String : AnyObject],
                        username = userInfo["name"] as? String,
                        profileImageURL = userInfo["profile_image_url"] as? String {
                            
                            //initialize it and append it to the array
                            let tweet = User(name: username, profileImageURL: profileImageURL)
                            
                            tweets.append(tweet)
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

