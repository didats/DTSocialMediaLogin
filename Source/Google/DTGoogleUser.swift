//
//  DTGoogleUser.swift
//  Tester
//
//  Created by Didats Triadi on 04/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation
import GoogleSignIn

struct DTGoogleUser {
    var userID: String
    var fullname: String
    var email: String
    var token: String
    var imageURL: URL?
    
    init(user: GIDGoogleUser) {
        self.userID = user.userID ?? "0"
        self.token = user.authentication.idToken ?? ""
        self.fullname = user.profile.name ?? ""
        self.email = user.profile.email ?? ""
        self.imageURL = user.profile.imageURL(withDimension: 100)
    }
    
    func convert() -> [String: Any] {
        return [
            "fullname": self.fullname,
            "email": self.email,
            "social_id": self.userID,
            "social_type": "GOOGLE"
        ]
    }
}
