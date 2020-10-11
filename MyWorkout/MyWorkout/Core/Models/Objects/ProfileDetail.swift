//
//  ProfileDetail.swift
//  MyWorkout
//
//  Created by João Palma on 11/10/2020.
//

import Foundation

class ProfileDetail {
    private let _description, _value: String
    
    init(description: String, value: String) {
        _description = description
        _value = value
    }
    
    func getDescription() -> String {
        _description
    }
    
    func getValue() -> String {
        _value
    }
}
