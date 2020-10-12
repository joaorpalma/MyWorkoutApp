//
//  Profile.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import Foundation

struct Profile {
    let _email, _password: String
    let _gender: Gender
    
    init(email: String, password: String, gender: Gender) {
        _email = email
        _password = password
        _gender = gender
    }
    
    func getEmail() -> String {
        _email
    }
    
    func getGender() -> String {
        _gender.rawValue
    }
    
    func matchesEmail(_ email: String) -> Bool {
        email.lowercased() == _email.lowercased()
    }
    
    func passwordMatch(_ password: String) -> Bool {
        password == _password
    }
}
