//
//  Profile.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import Foundation

struct ProfileStruct: Codable {
    var email: String
    var password: String
    var gender: String
    
    init(email: String = "", password: String = "", gender: String = "") {
        self.email = email
        self.password = password
        self.gender = gender
    }
}
