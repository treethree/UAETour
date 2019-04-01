//
//  User.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/28/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import Foundation

struct User {
    var id : String?
    var fName : String?
    var lName : String?
    var emailId : String?
    var mobile : String?
    var paswd : String?
    var dob : String?
    var gender : String?
    
    init(id : String? = nil, fName : String? = nil, lName : String? = nil, emailId : String? = nil, mobile : String? = nil, paswd : String? = nil, dob : String? = nil, gender : String? = nil) {
        self.id = id
        self.fName = fName
        self.lName = lName
        self.emailId = emailId
        self.mobile = mobile
        self.paswd = paswd
        self.dob = dob
        self.gender = gender
    }
}

typealias Attraction = [AttractionElement]

struct AttractionElement: Codable {
    let title, description: String
    let image: String
    let latitude, longitude, contact, timing: String
    let sitelink: String
    
    init(title : String, description : String, image : String, latitude: String, longitude : String, contact : String, timing : String, sitelink : String) {
        self.title = title
        self.description = description
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
        self.contact = contact
        self.timing = timing
        self.sitelink = sitelink
    }
}
