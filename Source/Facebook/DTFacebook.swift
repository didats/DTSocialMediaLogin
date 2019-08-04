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
    
    func setup(app: UIApplication, options: [UIApplication.LaunchOptionsKey: Any]?) {
        FBSDKCoreKit.ApplicationDelegate.shared.application(app, didFinishLaunchingWithOptions: options)
    }
    
    static func openURL(app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return  FBSDKCoreKit.ApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    func login(from viewController: UIViewController, done: @escaping(_ status: Bool, _ message: String, _ user: DTFacebookUser?) -> Void) {
        
        let login = FBSDKLoginKit.LoginManager()
        login.defaultAudience = .everyone
        login.logIn(permissions: ["email", "public_profile"], from: viewController) { (result, error) in
            DispatchQueue.main.async {
                if error != nil {
                    done(false, error!.localizedDescription, nil)
                }
                else if let result = result {
                    if result.isCancelled && result.declinedPermissions.count > 0 {
                        done(false, "facebook_cancel_declined", nil)
                    }
                    else {
                        //let userID = result.token?.userID
                        self.graph(str: "/me?fields=email,name", done: done)
                    }
                }
            }
        }
    }
    
    private func graph(str: String, done: @escaping(_ status: Bool, _ message: String, _ user: DTFacebookUser?) -> Void) {
        let connection = FBSDKCoreKit.GraphRequestConnection()
        let request = FBSDKCoreKit.GraphRequest(graphPath: str)
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

