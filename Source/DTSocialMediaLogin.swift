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
    
    private var _apple: Any? = nil
    @available(iOS 13.0, *)
    fileprivate var apple: DTApple {
        if _apple == nil {
            _apple = DTApple()
        }
        return _apple as! DTApple
    }
    
    public var scopes: [String] = []

    public static func initializer() {
        DTFacebook.initializer()
    }
    
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

    public static func sceneURL(_ url: URL?) {
        guard let url = url else { return }
        if url.absoluteString.contains("dttwitter-") {
            _ = DTTwitter.openURL(url)
        } else if url.absoluteString.contains("google") {
            _ = DTGoogleLogin.openURL(url, options: [:])
        }
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
            twitter.login(from: viewController) { (error, user) in
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
            google.viewController = viewController
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
                _apple = DTApple(from: viewController)
                (_apple as! DTApple).handleAuthorizationAppleIDButtonPress()
                (_apple as! DTApple).loggedIn = { status, message, user in
                    if let user = user {
                        callback(nil, DTSocialMediaUser(from: user))
                    }
                    else {
                        let error = DTError(title: "Apple Auth Error", description: message, code: -4)
                        callback(error, nil)
                    }
                }
            }
            else {
                let error = DTError(title: "iOS 13 requirement", description: "Sign in with Apple require iOS 13 and later", code: -3)
                callback(error, nil)
            }
        }
    }
    
}
