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
    
    public func save() {
        if googleClientID.count > 0 {
            DTCache.shared.save(googleClientID, key: SocialMediaKeys.GoogleID.rawValue)
        }
        if facebookID.count > 0 {
            DTCache.shared.save(facebookID, key: SocialMediaKeys.FacebookID.rawValue)
        }
        if twitterAppKey.count > 0 {
            DTCache.shared.save(twitterAppKey, key: SocialMediaKeys.TwitterKey.rawValue)
        }
        if twitterAppSecret.count > 0 {
            DTCache.shared.save(twitterAppSecret, key: SocialMediaKeys.TwitterSecret.rawValue)
        }
    }
    
    static func currentValue(_ type: SocialMediaKeys) -> String {
        if let item = DTCache.shared.hasObject(withKey: type.rawValue) as? String {
            return item
        }
        
        return ""
    }
}
