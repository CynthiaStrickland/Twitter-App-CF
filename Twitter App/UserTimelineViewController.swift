//
//  UserTimelineViewController.swift
//  TwitterCF
//
//  Created by William Cremin on 10/30/15.
//  Copyright © 2015 William Cremin. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    var currentUser: User!
    
    class func identifier() -> String {
        return "UserTimelineViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.getUserTweets()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let customTweetCellXib = UINib(nibName: "CustomCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customTweetCellXib, forCellReuseIdentifier: CustomTweetTableViewCell.identifier())
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let customHeaderXib = UINib(nibName: "CustomTableViewHeader", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(customHeaderXib, forCellReuseIdentifier: CustomHeader.identifier())

    }
    
    func getUserTweets() {
        TwitterService.tweetsFromHomeTimeline() { (error, tweets) -> () in
            if let error = error {
                print(error)
                return
            }
            if let tweets = tweets {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tweets = tweets
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    // MARK: UITableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CustomTweetTableViewCell.identifier(), forIndexPath: indexPath) as! CustomTweetTableViewCell
        
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier(CustomHeader.identifier()) as? CustomHeader
            headerCell!.currentUser = self.currentUser
            return headerCell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

}
