//
//  User.swift
//  MapProject
//
//  Created by Lushnikov Anatoliy on 08.10.2023.
//

import Foundation

struct User1 {
    var login: String
    var email: String
    
    init() {
        login = ""
        email = ""
    }
    init(login: String, email: String) {
        self.login = login
        self.email = email 
    }
}
