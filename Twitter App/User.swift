//
//  User.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit

class User {
    
    var name: String
    var profileImageURL: String
    var image: UIImage?
    var screenName: String
    var background: UIImage?
    var backgroundUrl: String
    let location: String

    
    
    
    init(name: String, profileImageURL: String, screenName: String, backgroundUrl:String, location: String) {
        self.name = name
        self.profileImageURL = profileImageURL
        self.screenName = screenName
        self.backgroundUrl = backgroundUrl
        self.location = location
        
    }
    
}