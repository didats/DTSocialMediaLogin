//
//  DTFacebookUser.swift
//  Tester
//
//  Created by Didats Triadi on 04/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

public struct DTFacebookUser {
    public var id: String
    public var fullname: String
    public var email: String
    
    init(fb: [String: Any]) {
        self.id = fb["id"] as? String ?? "0"
        self.fullname = fb["name"] as? String ?? ""
        self.email = fb["email"] as? String ?? ""
    }
}
