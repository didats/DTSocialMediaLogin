//
//  DTSocialMediaLogin.swift
//  DTSocialMediaLogin
//
//  Created by Didats Triadi on 01/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import UIKit

public enum DTSocialMediaProvider: String {
    case Facebook = "facebook"
    case Twitter = "twitter"
    case Google = "google"
    case Apple = "apple"
}

public class DTSocialMediaLogin: NSObject {

    public var googleClientID: String = ""
    public var facebookID: String = ""
    public var twitterSecret: String = ""
    public var twitterKey: String = ""
    
    private var facebook = DTFacebook()
    private var twitter: DTTwitter!
    private var google: DTGoogleLogin!
    private var apple: DTApple!
    
    public var scopes: [String] = []
    
    public static func setup(settings: DTSocialMediaKeys) -> DTSocialMediaLogin {
        let socialMedia = DTSocialMediaLogin()
        socialMedia.googleClientID = settings.googleClientID
        socialMedia.twitterKey = settings.twitterAppKey
        socialMedia.twitterSecret = settings.twitterAppSecret
        socialMedia.facebookID = settings.facebookID
        
        socialMedia.twitter = DTTwitter(key: settings.twitterAppKey, secret: settings.twitterAppSecret)
        socialMedia.google = DTGoogleLogin(clientID: settings.googleClientID)
        return socialMedia
    }
    
    public static func openURL(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        if url.absoluteString.contains("google") {
            return DTGoogleLogin.openURL(url, options: options)
        }
        else if url.absoluteString.contains("fb") {
            return DTFacebook.openURL(app: app, url: url, options: options)
        }
        else if url.absoluteString.contains("dttwitter-") {
            return DTTwitter.openURL(url)
        }
        
        return true
    }
    
    public func login(with type: DTSocialMediaProvider, from viewController: UIViewController, callback: @escaping(_ error: DTError?, _ user: DTSocialMediaUser?) -> Void) {
        
        switch type {
        case .Twitter:
            twitter.login { (error, user) in
                if let user = user {
                    callback(nil, DTSocialMediaUser(from: user))
                }
                else {
                    callback(error, nil)
                }
            }
        case .Facebook:
            facebook.scopes = scopes
            facebook.login(from: viewController) { (status, message, user) in
                if let user = user {
                    callback(nil, DTSocialMediaUser(from: user))
                }
                else {
                    let error = DTError(title: "Facebook Error", description: message, code: -3)
                    callback(error, nil)
                }
            }
        case .Google:
            google.scopes = scopes
            google.login()
            google.loggedIn = { status, message, user in
                if let user = user {
                    callback(nil, DTSocialMediaUser(from: user))
                }
                else {
                    let error = DTError(title: "Google Error", description: message, code: -3)
                    callback(error, nil)
                }
            }
        case .Apple:
            if #available(iOS 13, *) {
                apple = DTApple()
                apple.handleAuthorizationAppleIDButtonPress()
                apple.loggedIn = { error, user in
                    callback(error, user)
                }
            }
        }
    }
    
}
