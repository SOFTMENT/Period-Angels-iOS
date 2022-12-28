//
//  VolunteerModel.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit

class VolunteerModel :  NSObject, Codable {
    
    var name : String?
    var fullAddress : String?
    var emailId : String?
    var uid : String?
    var registeredAt : Date?
    var phoneNumber : String?
    var latitude : Double?
    var longitude : Double?
    var products  : Array<String>?
    var geoHash : String?
    var periodPads : Int?
    var tampons : Int?
    var reusableProducts : Int?
    var menstrualCup : Int?
    var plasticFree : Int?
    
    
    private static var volunteerData : VolunteerModel?
    
   
    static var data : VolunteerModel? {
        set(volunteerData) {
            self.volunteerData = volunteerData
        }
        get {
            return volunteerData
        }
    }
    
    override init() {
        
    }
}
