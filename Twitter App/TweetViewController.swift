//
//  TweetViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: String?
   
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tweetLabel: UILabel!
    

    class func identifier() -> String {
        return "TweetViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
    }
    
    //MARK:  TABLEVIEW METHODS
    
    
    func setUpTableView() {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        return cell
        
    }
    
}

