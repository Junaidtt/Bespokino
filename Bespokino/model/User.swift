//
//  User.swift
//  Bespokino
//
//  Created by Bespokino on 11/11/2560 BE.
//  Copyright © 2560 bespokinoapp. All rights reserved.
//

import Foundation


struct User {
    
    
    var firstName:String?
    var lastName:String?
    var email:String?
    var phoneNumber:String?
    var password:String?
    var pantWaistSize:String?
    
    init(firstname:String,lastname:String,email:String,phonenumber:String,pass:String,size:String) {
        
        self.firstName = firstname
        self.lastName = lastname
        self.email = email
        self.phoneNumber = phonenumber
        self.password = pass
        self.pantWaistSize = size
        
    }
    
 
    init(firstname:String,email:String,pass:String) {
        
        self.firstName = firstname

        self.email = email
 
        self.password = pass
   
        
    }
    
    init(email:String,pass:String) {
        self.email = email
        self.password = pass
        
    }
    
}








