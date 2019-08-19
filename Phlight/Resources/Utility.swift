//
//  Utility.swift
//  Phlight
//
//  Created by Atta khan on 08/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class Utility:NSObject {
    
    static let shared = Utility()

    func shakeView(_ view: UIView) {
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        anim.values = [
            NSValue( caTransform3D:CATransform3DMakeTranslation(-10, 0, 0 ) ),
            NSValue( caTransform3D:CATransform3DMakeTranslation( 10, 0, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 5
        anim.duration = 7/100
        view.layer.add( anim, forKey:nil )
    }
    
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    func setViewCornerRadius(_ view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    func isEmailVerified() -> Bool {
        return UserDefaults.standard.bool(forKey: "email_verified")
    }
    func isPhoneNumberVerified() -> Bool {
        return UserDefaults.standard.bool(forKey: "phone_verified")
    }
    func getUserId() -> Int {
        return UserDefaults.standard.integer(forKey: "user_id")
    }
   
    
}
struct Message {
    static let nAlert =                    "Alert"
    static let nCancel =                   "Cancel"
    static let nOk =                       "Ok"
    static let nSettings =                 "Settings"
    static let nNoInternet =               "No Internet Connection!"
    static let nInternetAvailable =         "Internet Connection Available"
    static let nServerError =              "Connectivity Error"
    static let nEmptyEmail =               "Email field is required"
    static let nEmptyPassword =            "Password field is required"
    static let nEmptyConfirmPassword =     "Confirm password field is required"
    static let nError =                    "Error"
    static let nSuccess =                  "Success"
    static let nEmailInvalid =             "Invalid email format"
    static let nDateFormatForDaysAgo =     "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let nPasswordLengthError =      "Password must contain at least 8 characters"
    static let nPasswordMatchError =       "Passwords do not match"
    static let nNoInterestError =          "Please select at least one interest"
    static let nDataLoss =                 "Your data will be loss"
    static let nInvalidStripInfo =         "Please enter valid credit card details"
    static let nEmptyCardNumber =          "Card number is required"
    static let nEmptyCardExpiry =          "Card expiry date is required"
    static let nEmptyCVV =                 "CVV number is required"
    static let nEmptyFullName =            "Full name is required"
    static let nEmptyUserName =            "Username is required"
    static let nInavlidUserName =          "Username is invalid"
    
}
