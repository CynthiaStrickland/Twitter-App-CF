//
//  TWITTERViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/27/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Social

class TWITTERViewController: UIViewController {

    @IBAction func tweetImage(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        var tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText("Check this out")
            tweetSheet.addImage(imageView.image)
            
            self.presentViewController(tweetSheet, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    @IBAction func imageSelected(sender: AnyObject) {
    }
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
