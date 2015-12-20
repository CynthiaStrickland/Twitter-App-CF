//
//  TWITTERViewController.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/27/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Social

class TWITTERViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var pickerController:UIImagePickerController = UIImagePickerController()
    
    @IBAction func tweetImage(sender: AnyObject) {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
        let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet.setInitialText("Check this out")
            tweetSheet.addImage(imageView.image)
            
            self.presentViewController(tweetSheet, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
    @IBAction func imageSelected(sender: AnyObject) {
            //Setting the Delegate and Accessing the library
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
            //Presenting the Controller
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {

        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ganesh.jpg")!)
    }
}
