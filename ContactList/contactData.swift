//
//  contactData.swift
//  ContactList
//
//  Created by Jay Prakash Sharma on 08/06/22.
//

import Foundation
class Contact{
    var firstName: String
    var lastName:String?
    var emailId:String
    var phoneNumber:Int
    
    // Initializing required types
    init(firstName:String, lastName:String, emailId:String,  phoneNumber:Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailId = emailId
        self.phoneNumber = phoneNumber
    }
}

