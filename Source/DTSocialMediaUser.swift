//
//  DTSocialMediaUser.swift
//  Tester
//
//  Created by Didats Triadi on 03/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

public struct DTSocialMediaUser {
    var id: String
    var name: String
    var email: String
    var profileImageURL: String
    
    init(from: DTTwitterUser) {
        self.id = from.id ?? "0"
        self.name = from.name ?? ""
        self.email = from.email ?? ""
        self.profileImageURL = from.profileImageURL ?? ""
    }
    
    init(from: DTGoogleUser) {
        self.id = from.userID
        self.name = from.fullname
        self.email = from.email
        self.profileImageURL = (from.imageURL != nil) ? from.imageURL!.absoluteString : ""
    }
    
    init(from: DTFacebookUser) {
        self.id = String(from.id)
        self.name = from.fullname
        self.email = from.email
        self.profileImageURL = "https://graph.facebook.com/\(self.id)/picture?type=normal"
    }
}
