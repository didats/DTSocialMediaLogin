//
//  DTTwitter.swift
//  DTSocialMediaLogin
//
//  Created by Didats Triadi on 01/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import UIKit
import OAuthSwift

final class DTTwitter {
    
    var key: String = ""
    var secret: String = ""
    var callback: String = ""
    
    private var oauth: OAuth1Swift?
    
    init(key: String, secret: String) {
        self.key = key
        self.secret = secret
        
        oauth = OAuth1Swift(
            consumerKey:    key,
            consumerSecret: secret,
            requestTokenUrl: DTTwitterURL.OAuth1.RequestToken,
            authorizeUrl:    DTTwitterURL.OAuth1.Authorize,
            accessTokenUrl:  DTTwitterURL.OAuth1.AccessToken
        )
    }
    
    static func openURL(_ url: URL) -> Bool {
        OAuthSwift.handle(url: url)
        return true
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch _ {
            return []
        }
    }
    
    func login(done: @escaping (_ error: DTError?, _ user: DTTwitterUser?) -> Void) {
        if key.count > 0 && secret.count > 0 {
            callback = "dttwitter-\(key)://"
            
            let _ = self.oauth?.authorize(withCallbackURL: self.callback, completionHandler: { (result) in
                    
                switch result {
                case .success(let (credential, _, _)):
                    
                    self.oauth?.client.get(DTTwitterURL.OAuth1.Account, completionHandler: { (resultClient) in
                        switch (resultClient) {
                        case .success(let  resp):
                            if let jsonData = (resp.dataString(encoding: .utf8) ?? "").data(using: .utf8) {
                                do {
                                    let decoder = JSONDecoder()
                                    var profile = try decoder.decode(DTTwitterUser.self, from: jsonData)
                                    profile.oauthToken = credential.oauthToken
                                    done(nil, profile)
                                } catch {
                                    let err = DTError(title: "JSON format", description: error.localizedDescription, code: -1)
                                    done(err, nil)
                                }
                            }
                        case .failure(let err):
                            let error = DTError(title: "OauthSwift Problem", description: err.description, code: err.errorCode)
                            done(error, nil)
                        }
                    })
                case .failure(let error):
                    let err = DTError(title: "OauthSwift Problem", description: error.description, code: error.errorCode)
                    done(err, nil)
                }
            })
        }
        else {
            let err = DTError(title: "Twitter Key & Secret", description: "Please provide twitter app key and twitter app secret", code: -2)
            done(err, nil)
        }
    }
}
