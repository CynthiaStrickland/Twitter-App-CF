//
//  Tweet.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import Foundation

class Tweet {
    
    let text : String
    let id : String
    var user: User?
    
    init(text : String, id : String, user: User? = nil) {
        self.text =  text
        self.id = id
        self.user = user
    }
}


