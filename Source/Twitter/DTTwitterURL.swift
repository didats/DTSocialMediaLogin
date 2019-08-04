//
//  DTTwitterURL.swift
//  Tester
//
//  Created by Didats Triadi on 03/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import Foundation

struct DTTwitterURL {
    struct OAuth1 {
        static let RequestToken = "https://api.twitter.com/oauth/request_token"
        static let Authorize = "https://api.twitter.com/oauth/authorize"
        static let Authenticate = "https://api.twitter.com/oauth/authenticate"
        static let AccessToken = "https://api.twitter.com/oauth/access_token"
        static let Invalidate = "https://api.twitter.com/oauth/invalidate_token"
        static let Account = "https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true&skip_status=1&include_entities=false"
    }
    struct OAuth2 {
        static let BearerToken = "https://api.twitter.com/oauth2/token"
        static let InvalidateBearerToken = "https://api.twitter.com/oauth2/invalidate_token"
    }
}
