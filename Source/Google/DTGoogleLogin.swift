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
    private var clientID: String
    
    init(clientID: String) {
        self.clientID = clientID
    }
    
    func login(from viewController: UIViewController) {
        let setClientID = GIDConfiguration.init(clientID: self.clientID)
        if scopes.count > 0 {
            GIDSignIn.sharedInstance.addScopes(scopes, presenting: viewController)
            return
        }
        GIDSignIn.sharedInstance.signIn(with: setClientID, presenting: viewController)
    }
    
    static func openURL(_ url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

extension DTGoogleLogin {
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
