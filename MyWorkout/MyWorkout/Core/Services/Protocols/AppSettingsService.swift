//
//  AppSettingsService.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import Foundation

protocol AppSettingsService where Self: AppSettingsServiceImp {
    var profileEmailSignedIn: String { get set }

    func clearProfileData()
}
