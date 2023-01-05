//
//  OrganiserModel.swift
//  Period Angels
//
//  Created by Vijay Rathore on 25/12/22.
//

import UIKit

class OrganiserModel : NSObject, Codable {

    var name : String?
    var fullAddress : String?
    var emailId : String?
    var uid : String?
    var registeredAt : Date?
    var type : String?
    var phoneNumber : String?
    var latitude : Double?
    var longitude : Double?
    var products : Array<String>?
    var geoHash : String?
    var mondayAvailable : Bool?
    var tuesdayAvailable : Bool?
    var wednesdayAvailable : Bool?
    var thursdayAvailable : Bool?
    var fridayAvailable : Bool?
    var saturdayAvailable : Bool?
    var sundayAvailable : Bool?
    var mondayStartTime : String?
    var mondayEndTime : String?
    var tuesdayStartTime : String?
    var tuesdayEndTime : String?
    var wednesdayStartTime : String?
    var wednesdayEndTime : String?
    var thursdayStartTime : String?
    var thursdayEndTime : String?
    var fridayStartTime : String?
    var fridayEndTime : String?
    var saturdayStartTime : String?
    var saturdayEndTime : String?
    var sundayStartTime : String?
    var sundayEndTime : String?
    
    private static var organiserData : OrganiserModel?
    
    static var organisationModel : [OrganiserModel] = []
    
   
    static var data : OrganiserModel? {
        set(organiserData) {
            self.organiserData = organiserData
        }
        get {
            return organiserData
        }
    }
    
    override init() {
        
    }
    
    
    
    
    
}
