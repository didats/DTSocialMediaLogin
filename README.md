
# DTSocialMediaLogin

![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)[![Version](https://img.shields.io/cocoapods/v/DTSocialMediaLogin.svg?style=flat)](http://cocoapods.org/pods/DTSocialMediaLogin)[![License](https://img.shields.io/cocoapods/l/DTSocialMediaLogin.svg?style=flat)](http://cocoapods.org/pods/DTSocialMediaLogin)[![Platform](https://img.shields.io/cocoapods/p/DTSocialMediaLogin?style=flat)](http://cocoapods.org/pods/DTSocialMediaLogin)

Handle iOS app login with Sign in with Apple, Twitter, Facebook and Google with ease. It will really saves you a lot of hours. The callback will give you these variables:

* id (`String`)
* name (`String`)
* email (`String`)
* profileImageURL (`String`)
* origin (`Any`)

The origin is a reference to the struct `DTAppleUser`, `DTGoogleUser`, `DTFacebookUser` and `DTTwitterUser`. For Google it has the property `user` that reference to `GIDGoogleUser` which you could use for any other Google APIs. While for Twitter, it has an `OAuthToken` to be use on other Twitter APIs.

## Requirements
* Base SDK: iOS 12
* Deployment Target: iOS 10.0 or greater

## Installation with Cocoapods

Add pod to your Podfile.
```
pod 'DTSocialMediaLogin'
```

Open your `AppDelegate.swift` file, and add these codes
```swift
// add import line
import DTSocialMediaLogin
...
...
...
// add openURL method
func  application(_ app:  UIApplication, open url:  URL, options:  [UIApplication.OpenURLOptionsKey  :  Any]  =  [:])  ->  Bool  {
	return  DTSocialMediaLogin.openURL(app: app, url: url, options: options) 
}
```

### Implementing Google Sign In
Get the `Google Client ID` and `Scheme Path URL` from [Google API Console](https://console.developers.google.com/). You may follow the tutorial at [Google Sign In](https://developers.google.com/identity/sign-in/ios/) to get those. Put your `Scheme Path URL` to the `URL Scheme` configuration on Xcode.

### Implementing Facebook Login
Setup an app on [Facebook Developer Portal](https://facebook.com/developer), and get the `Facebook App ID`. Put your `App ID` on the `Info.plist` file:
```
<key>FacebookAppID</key>
<string>0123456789</string>
```

Put `fb-your-fb-app-id-` on `URL Scheme`. If your App ID is 123, then `fb123` need to be on your `URL Scheme`. Put the `fbauth2` on your `URL Scheme` as well.

### Implementing Twitter Login
Go to [Twitter Developer Portal](https://developer.twitter.com/) and get `Twitter App Key` and `Twitter App Secret`. Put the `dttwitter-your-appkey-` to URL Scheme. If your app key is `1212` the put `dttwitter-1212`.

### Implementing Login with Apple
On XCode, go to `Signing & Capabilities` tab. Enable `Sign In with Apple` there.

### Code implementation
On your `AppDelegate` file, and method `didFinishLaunchingWithOptions`, add this line
```swift
DTSocialMediaLogin.initializer()
```

On your `SceneDelegate` file, add new method below:
```swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    DTSocialMediaLogin.sceneURL(URLContexts.first?.url)
}
```

On your Login View Controller, or whereever you wanna put the Login button, add import at the top and declare a property
```swift
import DTSocialMediaLogin

class LoginViewController: UIViewController {
	var socialLogin: DTSocialMediaLogin!
```

On your `viewDidLoad` method, add the initialization. Fill the string with empty if you do not need them.

```swift
let settings =  DTSocialMediaKeys(
			googleClientID:  "_google_client_id_", 
			facebookID:  "_faceebook_id_", 
			twitterAppKey:  "_twitter_api_key_", 
			twitterAppSecret:  "_twitter_secret_key_") 
socialLogin =  DTSocialMediaLogin.setup(settings: settings)
```

And on your login button action, specify with the code:
```swift
@objc  func  didButtonClick(_ sender:  UIButton)  {
	socialLogin.login(with:  .Facebook,  from: viewController)  {  error, user  in  
		// you will get the user detail on variable user  
		// user.name, user.email, user.id, user.profileImageURL  
	}  
}
```

That's all!

## Author

**Didats Triadi**

https://rimbunesia.com
http://didats.net

  

## How to say thank you

As you probably guess, this library took hours of my free time to work on. If you find this useful, please consider buying my Color Picker app, [‎Kelir on the Mac App Store](https://apps.apple.com/us/app/kelir-pro/id1186597992?mt=12), or my Quran app [Quranesia for macOS](https://rimbunesia.com/apps/quranesia-mac)

## License

Copyright (c) 2020 Didats Triadi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
