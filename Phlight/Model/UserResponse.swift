//
//  UserResponse.swift
//  Phlight
//
//  Created by Atta khan on 08/08/2019.
//  Copyright © 2019 Atta Khan. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class UserResponse: Mappable {
    var status              :       Bool?
    var message             :       String?
    var user_details        :       UserDetails?
    var store_data          :       [StoreModel]?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        status          <- map["status"]
        message         <- map["message"]
        user_details    <- map["user_details"]
        store_data      <- map["data"]
    }
}
class UserDetails: Mappable {
    var token           : String?
    var id              : Int?
    var name            : String?
    var mobile_number   : String?
    var email           : String?
    var email_verified  : Bool?
    var phone_verified  : Bool?
    var user_image      : String?
    var is_active       : String?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["id"]
        token           <- map["token"]
        mobile_number   <- map["mobile_no"]
        email           <- map["email"]
        email_verified  <- map["email_verified"]
        phone_verified  <- map["phone_verified"]
        user_image      <- map["user_image"]
        is_active       <- map["is_active"]
    }
}


class StoreModel: Mappable {
    var id          :       Int?
    var name        :       String?
    var email       :       String?
    var mobile_no   :       String?
    var address     :       String?
    var latitude    :       String?
    var longitude   :       String?
    var store_image :       String?
    var radius      :       String?
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        email       <- map["email"]
        mobile_no   <- map["mobile_no"]
        address     <- map["address"]
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
        store_image <- map["store_image"]
    }
}
