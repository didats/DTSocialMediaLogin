//
//  DTSocialMediaUser.swift
//  Tester
//
//  Created by Didats Triadi on 03/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

public struct DTSocialMediaUser {
    public var id: String
    public var name: String
    public var email: String
    public var profileImageURL: String
    public var origin: Any
    
    init(from: DTTwitterUser) {
        self.id = from.id ?? "0"
        self.name = from.name ?? ""
        self.email = from.email ?? ""
        self.profileImageURL = from.profileImageURL ?? ""
        self.origin = from
    }
    
    init(from: DTGoogleUser) {
        self.id = from.userID
        self.name = from.fullname
        self.email = from.email
        self.profileImageURL = (from.imageURL != nil) ? from.imageURL!.absoluteString : ""
        self.origin = from
    }
    
    init(from: DTFacebookUser) {
        self.id = from.id
        self.name = from.fullname
        self.email = from.email
        self.profileImageURL = "https://graph.facebook.com/\(self.id)/picture?type=normal"
        self.origin = from
    }
}
