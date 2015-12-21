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
    var tweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem = self.refreshBarButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.getAccount()
        let customTweetCellXib = UINib(nibName: "customTweetCell", bundle: nil)
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomTweetTableViewCell.identifier())
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 10
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.refreshBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "getTweets")
        self.navigationItem.rightBarButtonItem = self.refreshBarButton
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.spinner.hidesWhenStopped = true
    }

    
    func getAccount() {
        TwitterLoginService.loginTwitter({ (error, account) -> () in
            if let account = account {
                TwitterService.sharedService.account = account
                self.authenticateUser()
            }
        })
    }
    
    func authenticateUser(){
        TwitterService.getAuthUser { (error, user) -> () in
            if let user = user {
                TwitterService.sharedService.user = user
                self.getTweets()
            }
        }
    }
    
    func getTweets() {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.spinner)
        }
        TwitterService.tweetsFromHomeTimeline { (error, tweets) -> () in
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                })
            }
        }
    }
    
    // MARK: UITableView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == TweetDetailViewController.identifier() {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let tweet = self.tweets[indexPath.row]
                let tweetsDetailViewController = segue.destinationViewController as! TweetDetailViewController
                tweetsDetailViewController.tweet = tweet
            }
        }
    }
    
    // MARK: UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomTweetTableViewCell.identifier(), forIndexPath: indexPath) as! CustomTweetTableViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(TweetDetailViewController.identifier(), sender: nil)
    }
}



