//
//  TweetViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func refreshBarButton(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshBarButton: UIBarButtonItem!
    var spinner: UIActivityIndicatorView!
    
    var maxRows = 10
    var maxSection = 8

    var tweets = [Tweet]() {
        didSet {
            
            //  This is called when the getTweets Function Fires.   This reloads the tableview data and replaces spinner with refresh Button
            
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem = self.refreshBarButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.getAccount()
        
        //  Registering NIB so TableView can use the NIB
        
        let customTweetCellXib = UINib(nibName: "CustomTweetCell", bundle: nil)
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomTweetTableViewCell.identifier())
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 10
            //Any number greater than 2 - calculate cell height itself anyway
        self.tableView.rowHeight = UITableViewAutomaticDimension        //Predefined method...
        
                //initializing variables
        self.refreshBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "getTweets")
        self.navigationItem.rightBarButtonItem = self.refreshBarButton
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.spinner.hidesWhenStopped = true
    }

    
    func getAccount() {
        TwitterLoginService.loginTwitter({ (error, account) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let account = account {
                TwitterService.sharedService.account = account
                self.authenticateUser()
            }
        })
    }
    
    func authenticateUser(){
        TwitterService.getAuthUser { (error, user) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let user = user {
                TwitterService.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    func getTweets() {
        
          //Basically creating a BarButton with a custom view because the Spinner is of type ActivityIndicator, not BarButtonItem
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.spinner)
        }
        TwitterService.tweetsFromHomeTimeline { (error, tweets) -> () in
            if let error = error {
                print(error)
                return
            }
            
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                })
            }
        }
    }
    
    // MARK: UITableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return maxSection
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomTweetTableViewCell.identifier(), forIndexPath: indexPath) as! CustomTweetTableViewCell
        
        //   This is no long an instance of UITableView because I created a XIB file
        
        cell.tweet = tweets[indexPath.row]
        cell.backgroundColor = cellColorForIndex(indexPath)
        
        return cell
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tweet = self.tweets[indexPath.row]
            //create an instance of TweetDetailViewController
        let tweetDetailViewcontroller = self.storyboard?.instantiateViewControllerWithIdentifier(TweetDetailViewController.identifier()) as! TweetDetailViewController
        
        tweetDetailViewcontroller.tweet = tweet
        
        self.navigationController?.pushViewController(tweetDetailViewcontroller, animated: true)
        
    }
    
//// MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == TweetDetailViewController.identifier() {
//            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
//            
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                
//            let tweet = self.tweets[indexPath.row]
//    
//            tweetDetailViewController.tweet = tweet
//            
//        }
//    }
//}

    
    
    
    func cellColorForIndex(indexPath:NSIndexPath) -> UIColor {
        let row = CGFloat(indexPath.row)
        let section = CGFloat(indexPath.section)
        
        let saturation = 1.0 - row / CGFloat(maxRows)
        let hue = section / CGFloat(maxSection)
        
        return UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
        }
    }

