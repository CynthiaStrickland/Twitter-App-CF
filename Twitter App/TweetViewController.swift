//
//  TweetViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var tweets = [Tweet]()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tweetLabel: UILabel!
    

    class func identifier() -> String {
        return "TweetViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.getTweets()
    }
    
    func getTweets () {
        
        if let tweetJSONFileURL = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") {
            
            if let tweetJSONData = NSData(contentsOfURL: tweetJSONFileURL) {
                
                //Create an array of data out of the tweets
                
                if let tweets = TweetJSON.tweetFromJSONData(tweetJSONData) {
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
        
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = "Tweet id is: \(tweet.id)"
        
        return cell
        
    }
    
}

