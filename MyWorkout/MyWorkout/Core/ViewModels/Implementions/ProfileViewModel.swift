//
//  ProfileViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

class ProfileViewModel: ViewModelBase {
    private let _jsonFileManager: JsonFileManager
    private let _appSettingsService: AppSettingsService
    private let _dialogService: DialogService
    
    private var _profileList: [Profile] = []
    private(set) var profileDetails: [ProfileDetail] = []
    
    private(set) lazy var signOutCommand = Command(_signOut)
    
    init(jsonFileManager: JsonFileManager, appSettingsService: AppSettingsService, dialogService: DialogService) {
        _jsonFileManager = jsonFileManager
        _appSettingsService = appSettingsService
        _dialogService = dialogService
    }
    
    override func initialize() {
        _getProfilesInFileManager()
        _getSignedInProfile()
    }
    
    
    private func _getProfilesInFileManager() {
        let profiles: [ProfileStruct]? = _jsonFileManager.retrieveFromJsonFile(fileName: "profiles_db")
        
        profiles.map { $0.forEach { profile in
            _profileList.append(Profile(email: profile.email, password: profile.password, gender: Gender.init(rawValue: profile.gender)!))
        }}
    }
    
    
    private func _getSignedInProfile() {
        let profileEmail = _appSettingsService.profileEmailSignedIn
        let profile = _profileList.first(where: { $0.matchesEmail(profileEmail) })
        _fillProfileDetails(profile!)
    }
    
    private func _fillProfileDetails(_ profile: Profile) {
        profileDetails.append(contentsOf: [
            ProfileDetail(description: "Email", value: profile.getEmail()),
            ProfileDetail(description: "Gender", value: profile.getGender())
        ])
    }
    
    private func _signOut() {
        _clearProfileSettings()
        navigationService.navigateAndSetAsContainer(viewModel: WelcomeViewModel.self)
        _dialogService.showInfo("Sign out successfully.", informationType: .good)
    }
    
    private func _clearProfileSettings() {
        _appSettingsService.clearProfileData()
    }
}
