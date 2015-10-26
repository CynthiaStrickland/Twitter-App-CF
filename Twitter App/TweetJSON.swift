//
//  TweetJSON.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import Foundation

class TweetJSON {
    
    class func tweetFromJSONData(json: NSData) -> [Tweet]? {
    
    do {
        
         // Can user successfully translate the JSON data
        if let rootObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
            
            //create / initialize an array
            var tweets = [Tweet]()
            
            //enumerate through the array
                for tweetObject in rootObject {
                    //if it has values
                    if let text = tweetObject["text"] as? String, id = tweetObject["id_str"] as? String {
                        //initialize it and append it to the array
                        let tweet = Tweet(text: text, id: id)
                        tweets.append(tweet)
                }
            }
                return tweets
                
        }
            
    } catch _ {

            
        }
        return nil
        
    
    }
}
