//
//  DTGoogleLogin.swift
//  Academy
//
//  Created by Didats Triadi on 22/06/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import UIKit
import GoogleSignIn

class DTGoogleLogin: NSObject {
    var loggedIn: ((_ status: Bool, _ error: String, _ user: DTGoogleUser?) -> Void)?
    var scopes: [String] = []
    
    init(clientID: String) {
        super.init()
        GIDSignIn.sharedInstance()?.clientID = clientID
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    func login() {
        if scopes.count > 0 {
            GIDSignIn.sharedInstance()?.scopes = scopes
        }
        GIDSignIn.sharedInstance().signIn()
    }
    
    static func openURL(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance()?.handle(url, sourceApplication: (options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String), annotation: options[UIApplication.OpenURLOptionsKey.annotation]) ?? false
    }
}

extension DTGoogleLogin: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            self.loggedIn?(false, error.localizedDescription, nil)
        }
        else {
            let user = DTGoogleUser(user: user)
            self.loggedIn?(true, "", user)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        self.loggedIn?(false, error.localizedDescription, nil)
    }
}

extension DTGoogleLogin: GIDSignInUIDelegate {
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
    }
}


