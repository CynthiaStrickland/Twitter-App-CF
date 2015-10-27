//
//  User.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import Foundation

class User {
    let username: String
    let profileImageURL: String
    
    init(username: String, profileImageURL: String) {
        self.username = username
        self.profileImageURL = profileImageURL
    }
}