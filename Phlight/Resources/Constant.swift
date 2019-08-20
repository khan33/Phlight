//
//  Constant.swift
//  Phlight
//
//  Created by Atta khan on 08/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//
//

import UIKit

let keyWindow =  UIApplication.shared.keyWindow
let offSet: Int = 1000

var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  0.0
var DEVICE_LONG = 0.0
var DEVICE_ADDRESS = ""

var DEVICE_ENDLAT =  31.504486
var DEVICE_ENDLONG = 74.331563

let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)
//
//LIVE URL Not working currently
let BASE_URL = "http://phlightusa.com/phlight/api/"

let LOGIN = BASE_URL + "user/login"
let REGISTER = BASE_URL + "user/register"
let UPDATE_PROFILE = BASE_URL + "user/update_profile"
let SAVE_CURRETN_LOCATION = BASE_URL + "user/user_current_address"
let FORGOT_PASSWORD =   BASE_URL + "user/forgot_password"
let VERIFY_EMAIL = BASE_URL + ""
let RESEND_EMAIL = BASE_URL + ""
let VERIFY_OTP_CODE = BASE_URL + "user/verify_code"
let RESEND_OTP = BASE_URL + ""
let ALL_STROE   = BASE_URL + "user/all_stores"
let SOCIAL_LOGIN = BASE_URL + "user/socialLogin"
