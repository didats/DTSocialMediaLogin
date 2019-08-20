# DTSocialMediaLogin
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Version](https://img.shields.io/cocoapods/v/DTSocialMediaLogin.svg?style=flat)](http://cocoapods.org/pods/DTSocialMediaLogin)
[![License](https://img.shields.io/cocoapods/l/DTSocialMediaLogin.svg?style=flat)](http://cocoapods.org/pods/DTSocialMediaLogin)
[![Platform](https://img.shields.io/cocoapods/p/DTSocialMediaLogin?style=flat)](http://cocoapods.org/pods/DTSocialMediaLogin)

Handle iOS app login with Twitter, Facebook and Google with ease. It will really saves you a lot of hours.  The callback will give you these variables:  
* id (`String`)
* name (`String`)
* email (`String`)
* profileImageURL (`String`)
* origin (`Any`)

The origin is a reference to the struct `DTGoogleUser`, `DTFacebookUser` and `DTTwitterUser`. For Google it has the property `user` that reference to `GIDGoogleUser`  which you could use for any other Google APIs. While for Twitter, it has an `OAuthToken` to be use on other Twitter APIs.

## Requirements
* Base SDK: iOS 12
* Deployment Target: iOS 10.0 or greater

## Installation with Cocoapods
To setup, go to [the tutorial site](http://english.didats.net/add-login-to-twitter-facebook-and-google-to-your-ios-app/)

## Author
**Didats Triadi**  
https://rimbunesia.com  
http://didats.net

## How to say thank you
As you probably guess, this library took  hours of my free time to work on. If you find this useful, please consider buying my Color Picker app,  [‎Kelir on the Mac App Store](https://apps.apple.com/us/app/kelir-pro/id1186597992?mt=12)

## License
Copyright (c) 2019 Didats Triadi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal  in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
