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
    public var origin: Any
    
    init(credential: ASAuthorizationAppleIDCredential) {
        let given = credential.fullName?.givenName ?? ""
        let family = credential.fullName?.familyName ?? ""
        self.id = credential.user
        self.fullname = "\(given) \(family)"
        self.email = credential.email ?? ""
        self.origin = credential
    }
}

@available(iOS 13, *)
class DTApple: NSObject {
    var viewController: UIViewController!
    
    var loggedIn: ((_ status: Bool, _ error: String, _ user: DTAppleUser?) -> Void)?
    
    init(wrapper: UIView, from viewController: UIViewController) {
        super.init()
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        wrapper.addSubview(authorizationButton)
        self.viewController = viewController
    }
    
    init(button: UIButton, from viewController: UIViewController) {
        super.init()
        button.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        self.viewController = viewController
    }
    
    init(from viewController: UIViewController) {
        super.init()
        self.viewController = viewController
    }
    
    override init() {
        super.init()
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

@available(iOS 13, *)
extension DTApple: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userApple = DTAppleUser(credential: appleIDCredential)
            self.loggedIn?(true, "", userApple)
            
        default:
            self.loggedIn?(false, "Your Apple credential is not found", nil)
        }
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        self.loggedIn?(false, error.localizedDescription, nil)
    }
}

@available(iOS 13, *)
extension DTApple: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.viewController.view.window!
    }
}
