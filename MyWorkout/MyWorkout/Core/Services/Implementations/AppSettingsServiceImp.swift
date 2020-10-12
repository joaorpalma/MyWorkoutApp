//
//  AppSettingsService.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import Foundation

class AppSettingsServiceImp: AppSettingsService {
    private let _userDefaults = UserDefaults.standard
    
    var profileEmailSignedIn: String {
        get {
            return _userDefaults.string(forKey: "userEmail") ?? ""
        } set {
            _userDefaults.set(newValue, forKey: "userEmail")
        }
    }
    
    func clearProfileData() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }
}
