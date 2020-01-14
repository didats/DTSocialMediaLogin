//
//  DTApple.swift
//  DTSocialMediaLogin
//
//  Created by Didats Triadi on 14/01/20.
//  Copyright © 2020 Rimbunesia. All rights reserved.
//

import UIKit
import AuthenticationServices

@available(iOS 13, *)
public struct DTAppleUser {
    public var id: String
    public var fullname: String
    public var email: String
    
    init(credential: ASAuthorizationAppleIDCredential) {
        self.id = credential.user ?? ""
        self.fullname = credential.fullName ?? ""
        self.email = credential.email ?? ""
    }
}

@available(iOS 13, *)
class DTApple: NSObject {
    static let shared = DTApple()
    var loggedIn: ((_ error: DTError?, _ user: DTAppleUser?) -> Void)?
    
    init(wrapper: UIView) {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        wrapper.addSubview(authorizationButton)
    }
    
    init(button: UIButton) {
        button.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    init() {
        
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension DTApple: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            let userApple = DTAppleUser(credential: appleIDCredential)
            self.loggedIn?(nil, userApple)
            
        default:
            let error = DTError(title: "Error credential", description: "Your Apple credential is not found", code: -1)
            self.loggedIn?(error, nil)
        }
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        let error = DTError(title: "Authorization error", description: error.localizedDescription, code: -2)
        self.loggedIn?(error, nil)
    }
}

extension DTApple: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
