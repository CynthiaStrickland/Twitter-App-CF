//
//  TwitterLogin.swift
//  Twitter App
//
//  Created by Cynthia Whitlatch on 10/26/15.
//  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
//

import Foundation
import Accounts

class LoginService {
    class func loginForTwitter(completionHandler : (String?, ACAccount?) -> (Void)) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted, error) -> Void in
            if let _ = error {
                completionHandler("Please sign in",nil)
                return
            } else {
                if granted {
                    if let account = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                        completionHandler(nil,account)
                    }
                } else {
                    //tell the user this app needs twitter
                    completionHandler("This app requires twitter access",nil)
                    
                }
            }
        }
    }
}