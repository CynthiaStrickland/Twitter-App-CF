//
//  TwitterServiceRequest.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Accounts
import Social

class TwitterService {
    
    static let sharedService = TwitterService()
    
    var account: ACAccount?
    
    private init() {}
    
    class func tweetsFromHomeTimeline(completionHandler : (String?, [Tweet]?) -> (Void)) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")!, parameters: nil)
        request.account = self.sharedService.account
        
        request.performRequestWithHandler { (data, response, error) -> Void in
            if let _ = error {
                completionHandler("could not connect to the server", nil)
            } else {
                print(response.statusCode)
                        //RANGED SWITCH STATEMENT
                switch response.statusCode {
                case 200...299:
                    let tweets = TweetJSONParser.tweetFromJSONData(data)
                    completionHandler(nil,tweets)
                case 400...499:
                    completionHandler("this is our fault", nil)
                case 500...599:
                    completionHandler("this is the servers fault", nil)
                default:
                    completionHandler("error occurred", nil)
                }
                
            }
        }
        
    }
}