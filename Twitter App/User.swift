//
//  User.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import Foundation

class User {
    
    let name: String
    let profileImageURL: String
    
    init(name: String, profileImageURL: String) {
        self.name = name
        self.profileImageURL = profileImageURL
    }
}