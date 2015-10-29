//
//  TwitterService.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import Foundation
import Accounts
import Social

class TwitterService {
    // Setup singleton instance
    static let sharedService = TwitterService()
    
    // Setup instance variables
    var account : ACAccount?
    var user : User?
    
    class func tweetsFromHomeTimeline(completion: (String?, [Tweet]?) -> () ) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json"), parameters: nil)
        
        if let account = self.sharedService.account {
            request.account = account

            
            request.performRequestWithHandler { (data, response, error) -> Void in
                if let error = error {
                    print(error.description)
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json could not be completed.", nil); return
                }
                
                switch response.statusCode {
                case 200...299:
                    let tweets = TweetJSONParser.TweetFromJSONData(data)
                    completion(nil, tweets)
                case 400...499:
                    print(response.description)
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [server side error].", nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/statuses/home_timeline.json returned status code \(response.statusCode) [unknown error].", nil)
                }
            }
        }
        
    }
    
    class func getAuthUser(completion: (String?, User?)-> ()) {
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        
        if let account = self.sharedService.account {
            request.account = account
            
            request.performRequestWithHandler { (data, response, error) -> Void in
                
                if let error = error {
                    print(error)
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json could not be completed.", nil); return
                }
                
                if let data = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    print(data  )
                }
            
                switch response.statusCode {
                case 200...299:
                    do {
                        if let userData = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String : AnyObject] {
                            if let user = TweetJSONParser.userFromData(userData){
                                completion(nil, user); return
                            }
                            completion("ERROR: unable create user object from de-serialized JSON object", nil)
                        }
                    } catch {
                        completion("ERROR: NSJSONSerialization.JSONObjectWithData was unable to de-serialize JSON object.", nil)
                    }
                case 400...499:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [user input error].", nil)
                case 500...599:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [server side error].", nil)
                default:
                    completion("ERROR: SLRequest type GET for /1.1/account/verify_credentials.json returned status code \(response.statusCode) [unknown error].", nil)
                }
            }
        }
    }
    
}

