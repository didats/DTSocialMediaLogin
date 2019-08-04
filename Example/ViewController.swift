//
//  ViewController.swift
//  Example
//
//  Created by Didats Triadi on 01/08/19.
//  Copyright © 2019 Rimbunesia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var socialMedia: DTSocialMediaLogin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // fill in the parameter, leave it blank if you don't use it.
        let settings = DTSocialMediaKeys(googleClientID: "__", facebookID: "__", twitterAppKey: "__", twitterAppSecret: "__")
        socialMedia = DTSocialMediaLogin.setup(settings: settings)
    }

    @IBAction func clicked(_ sender: UIButton) {
        if sender.tag == 1 {
            socialMedia.login(with: .Twitter, from: self) { (error, user) in
                print("User: \(user)")
            }
        }
        else if sender.tag == 2 {
            socialMedia.login(with: .Facebook, from: self) { (error, user) in
                print("User: \(user)")
            }
        }
        else if sender.tag == 3 {
            socialMedia.login(with: .Google, from: self) { (error, user) in
                print("User: \(user)")
            }
        }
    }
}

