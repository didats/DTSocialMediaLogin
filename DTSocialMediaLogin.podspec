Pod::Spec.new do |spec|
  spec.name         = "DTSocialMediaLogin"
  spec.version      = "0.0.5"
  spec.summary      = "Handle Login with Facebook, Google, and Twitter"
  spec.description  = "Handle iOS app login with Twitter, Facebook and Google with ease."
  spec.homepage     = "https://github.com/didats/DTSocialMediaLogin"

  spec.license      = "MIT"

  spec.authors	    = { "Didats Triadi" => "didats@gmail.com" }

  spec.platform     = :ios
  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/didats/DTSocialMediaLogin.git", :tag => "#{spec.version}" }
  spec.swift_version = '5.0'

  spec.source_files  = "Source/**/*.swift"
  spec.static_framework = true

  spec.dependency 'FBSDKCoreKit', '~> 5.2.3'
  spec.dependency 'FBSDKLoginKit', '~> 5.2.3'
  spec.dependency 'GoogleSignIn', '~> 4.4.0'
  spec.dependency 'OAuthSwift', '~> 2.0.0'

end
