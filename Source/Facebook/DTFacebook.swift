//
//  DTFacebook.swift
//  Oor Doc
//
//  Created by Didats Triadi on 26/02/19.
//  Copyright © 2019 oor. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class DTFacebook: NSObject {
    static let shared = DTFacebook()
    //private var scopes: [String] = ["email", "public_profile"]
    public var scopes: [String] = []

    public static func initializer() {
        ApplicationDelegate.initializeSDK(nil)
    }
    
    func setup(app: UIApplication, options: [UIApplication.LaunchOptionsKey: Any]?) {
        FBSDKCoreKit.ApplicationDelegate.shared.application(app, didFinishLaunchingWithOptions: options)
    }
    
    static func openURL(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return  FBSDKCoreKit.ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func login(from viewController: UIViewController, done: @escaping(_ status: Bool, _ message: String, _ user: DTFacebookUser?) -> Void) {
        
        let login = FBSDKLoginKit.LoginManager()
        login.defaultAudience = .everyone
        
        if scopes.count == 0 {
            scopes = ["email", "public_profile"]
        }
        
        login.logIn(permissions: scopes, from: viewController) { (result, error) in
            DispatchQueue.main.async {
                if error != nil {
                    done(false, error!.localizedDescription, nil)
                }
                else if let result = result {
                    if result.isCancelled && result.declinedPermissions.count > 0 {
                        done(false, "facebook_cancel_declined", nil)
                    }
                    else {
                        self.graph(done: done)
                    }
                }
            }
        }
    }
    
    private func graph(done: @escaping(_ status: Bool, _ message: String, _ user: DTFacebookUser?) -> Void) {
        let connection = FBSDKCoreKit.GraphRequestConnection()
        let request = FBSDKCoreKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"])
        connection.add(request) { (conn, result, error) in
            if error != nil {
                done(false, error!.localizedDescription, nil)
            }
            else if let resultData = result as? [String: Any] {
                let fb = DTFacebookUser(fb: resultData)
                done(true, "", fb)
            }
            else {
                done(false, "facebook_failed", nil)
            }
        }
        connection.start()
    }
    
}

