//
//  UserModel.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit

class UserModel : NSObject, Codable {
    
    var fullName : String?
    var email : String?
    var uid : String?
    var registredAt : Date?
    var regiType : String?
    var organizer : Bool?
    var volunteer : Bool?
    
    private static var userData : UserModel?
    
   
    static var data : UserModel? {
        set(userData) {
            self.userData = userData
        }
        get {
            return userData
        }
    }
    
    override init() {
        
    }
    
}
