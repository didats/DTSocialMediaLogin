//
//  DTGoogleUser.swift
//  Tester
//
//  Created by Didats Triadi on 04/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation
import GoogleSignIn

public struct DTGoogleUser {
    public var userID: String
    public var fullname: String
    public var email: String
    public var token: String
    public var imageURL: URL?
    public var user:  GIDGoogleUser
    
    init(user: GIDGoogleUser) {
        self.userID = user.userID ?? "0"
        self.token = user.authentication.idToken ?? ""
        self.fullname = user.profile.name ?? ""
        self.email = user.profile.email ?? ""
        self.imageURL = user.profile.imageURL(withDimension: 100)
        self.user = user
    }
}
