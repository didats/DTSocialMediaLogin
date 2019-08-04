//
//  DTTwitterUser.swift
//  Tester
//
//  Created by Didats Triadi on 03/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

struct DTTwitterUser: Codable {
    var email: String?
    var id: String?
    var name: String?
    var profileImageURL: String?
    var username: String?
    
    private enum CodingKeys: String, CodingKey {
        case email
        case id = "id_str"
        case name
        case profileImageURL = "profile_image_url"
        case username = "screen_name"
    }
}
