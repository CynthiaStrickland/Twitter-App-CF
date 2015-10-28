//
//  LoginService.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Accounts

class LoginService: UIViewController, UITableViewDataSource, UITableViewDelegate {


class LoginService {
    class func loginForTwitter(completionHandler : (String?, ACAccount?) -> (Void)) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if let _ = error {
                completionHandler("Please sign in",nil)
                return
            } else {
                if granted {
                    if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                        completionHandler(nil,account)
                    }
                } else {
                    //tell the user this app needs twitter
                    completionHandler("This app requires twitter access",nil)
                    
                }
            }
        }
    }
}


    var users = [User]()
    var tweets = [Tweet]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    class func identifier() -> String {
        return "TweetViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getTweets()
    }
    
    func getAccount() {
    
        TwitterLoginService.loginForTwitter { (error, account) -> (Void) in
            
            if let _ = error {
            }
            
            if let account = account {

                TwitterService.sharedService.account = account
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.activityIndicator.startAnimating()
                })
                
                TwitterService.tweetFromHomeTimeline( { (error, tweets) -> (Void) in
                    if let tweets = tweets {
                        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
                            self.tweets = tweets
                            self.activityIndicator.stopAnimating()
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    func oauthUser() {
        
    }
    
    
    
    func getTweets () {
        
        if let tweetJSONFileURL = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") {
            
            if let tweetJSONData = NSData(contentsOfURL: tweetJSONFileURL) {
                
                //Create an array of data out of the tweets
                
                if let tweets = TweetJSONParser.tweetFromJSONData(tweetJSONData) {
                    self.tweets = tweets
                    self.tableView.reloadData()
                } 
            }
        }
    }

    //MARK:  TABLEVIEW METHODS
    
    func setUpTableView() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let tweet = self.tweets[indexPath.row]
        
        cell.textLabel?.text = "User tweeted \(tweet.text)"
        cell.detailTextLabel?.text = "Tweet id is: \(tweet.id)"
        
        return cell
    }
    
}
