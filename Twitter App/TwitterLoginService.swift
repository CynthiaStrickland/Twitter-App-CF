//
//  TwitterLoginService.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import UIKit
import Accounts

class TwitterLoginService {
    
    class func loginTwitter(completionHandler : (String?, ACAccount?) -> (Void)) {        
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in            
            if let _ = error {
                completionHandler("Please sign in", nil)
                return
            } else {
                if granted {
                    if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                        completionHandler(nil, account)
                    }
                } else {
                    completionHandler("This app requires twitter access",nil)
                    
                }
            }
        }
    }
}