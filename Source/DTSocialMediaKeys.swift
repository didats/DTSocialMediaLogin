//
//  DTSocialMediaKeys.swift
//  Tester
//
//  Created by Didats Triadi on 03/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

enum SocialMediaKeys: String {
    case GoogleID = "googleID"
    case FacebookID = "facebookID"
    case TwitterKey = "twitterKey"
    case TwitterSecret = "twitterSecret"
}

public struct DTSocialMediaKeys {
    var googleClientID: String
    var facebookID: String
    var twitterAppKey: String
    var twitterAppSecret: String
    
    public init(googleClientID: String, facebookID: String, twitterAppKey: String, twitterAppSecret: String) {
        self.googleClientID = googleClientID
        self.facebookID = facebookID
        self.twitterAppKey = twitterAppKey
        self.twitterAppSecret = twitterAppSecret
    }
}
