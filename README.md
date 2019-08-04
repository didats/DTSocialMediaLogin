_Currently on high development, will push the codes once everything is ready_

# DTSocialMediaLogin
[Version](http://cocoapods.org/pods/DTSocialMediaLogin)
[License](http://cocoapods.org/pods/DTSocialMediaLogin)
[Platform](http://cocoapods.org/pods/DTSocialMediaLogin)

Handle iOS app login with Twitter, Facebook and Google with ease. It will really saves you a lot of hours.  The callback will give you these variables: **id**, **name**, **email**, **profile image url**.

## Requirements
* Base SDK: iOS 12
* Deployment Target: iOS 10.0 or greater

## Installation with Cocoapods
Add following in your Podfile

```
pod ‘DTSocialMediaLogin’
```

## Dependencies
This library is using [FBSDKCoreKit](https://cocoapods.org/pods/FBSDKCoreKit), [FBSDKLoginKit](https://cocoapods.org/pods/FBSDKLoginKit), [GoogleSignIn](https://cocoapods.org/pods/GoogleSignIn), and [OAuthSwift](https://cocoapods.org/pods/OAuthSwift).

## Setting up
Before implementing any codes, you will need to have these 4 items which you could get from the development  portal of each Social Media. Assuming you knew the portal, so I am not gonna go through in detail.

1. **Google**   
Go to Google APIs Console. Create a project, go to APIs & Services, Credentials, and create one. You gonna need the **Client ID**

2. **Facebook**   
Go to Facebook Developer Portal, and create an app with iOS Platform. Make sure everything okay so you could activate the app to public. You gonna need to get Application ID here.

3. **Twitter**  
Register to their Developer Portal, and create new app. Do not forget to tick the _Using Twitter Login_ option, and put the callback with “**dttwitter-{your_app_key}**” (remove the curly bracket _{}_ for sure). You gonna need

## URL Schemes
Once you have done with the setup above, you gonna need to fill in the URL Schemes for each social media platform. Go to your target app, click on Info tab, and scroll to the URL Types section.

1. **Facebook**  
Add fb{your_app_id} (remove the curly braces please)
2. **Google**   
Follow the tutorial on how to get get started with Google Login
3. **Twitter**   
Add dttwitter-{your_app_key} (again, remove the curly braces)

## Usage
The sample project is there to let you see it, but I will keep the codes here for faster implementation.

Open your **AppDelegate.swift**
```swift

// Add to your openURL method
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return DTSocialMediaLogin.openURL(app, url: url, options: options)
}
```

At your implementation file
```swift

// Add import at the header of the file
import DTSocialMediaLogin

// add the variable attribute
var socialMedia: DTSocialMediaLogin!

// on viewDidLoad()
override func viewDidLoad() {
	super.viewDidLoad()
	let settings = DTSocialMediaKeys(
					googleClientID: "", 
					facebookID: "", 
					twitterAppKey: "", 
					twitterAppSecret: "")
	socialMedia = DTSocialMediaLogin.setup(settings: settings)
}

// on button action
@IBAction func buttonClicked(_ sender: Any) {
	socialMedia.login(with: .Facebook) { (error, user) in
		if let user = user {
			//user.id
			//user.email
			//user.name
			//user.profileImageURL
		}
	}
}

```

## Author
**Didats Triadi**  
http://rimbunesia.com  

## How to say thank you
As you probably guess, this library took  hours of my free time to work on. If you find this useful, please consider buying my Color Picker app, **Kelir** on  the AppStore.  [‎Kelir on the Mac App Store](https://apps.apple.com/us/app/kelir-pro/id1186597992?mt=12)

## License
Copyright (c) 2019 Didats Triadi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal  in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.