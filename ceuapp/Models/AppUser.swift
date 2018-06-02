//
//  AppUser.swift
//  ceuapp
//
//  Created by Israel Barros on 13/09/17.
//  Copyright © 2017 CIT. All rights reserved.
//

import Foundation

class AppUser {
    
    let userName: String
    let userTitle: String
    let userDescription: String
    let userEmail: String
    let userCompany: String
    let userType: String
    
    init(name:String, title:String, decription: String, email: String, company: String, type: String) {
        self.userName = name
        self.userTitle = title
        self.userEmail = email
        self.userDescription = decription
        self.userCompany = company
        self.userType = type
    }
}
