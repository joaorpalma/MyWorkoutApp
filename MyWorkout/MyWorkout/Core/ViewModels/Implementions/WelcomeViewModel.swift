//
//  WelcomeViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

class WelcomeViewModel: ViewModelBase {
    private let _dialogService: DialogService
    private let _jsonFileManager: JsonFileManager
    private let _appSettingsService: AppSettingsService
    
    private var _profileList: [Profile] = []
    private let _defaultProfile = ProfileStruct(email: "registered@email.com", password: "password", gender: "Male")
    
    private(set) lazy var checkEmailCommand = WpCommand<String>(_checkEmail)
    
    init(dialogService: DialogService, jsonFileManager: JsonFileManager, appSettingsService: AppSettingsService) {
        _dialogService = dialogService
        _jsonFileManager = jsonFileManager
        _appSettingsService = appSettingsService
    }
    
    override func initialize() {
        _checkIfUserIsLoggedIn()
    }
    
    private func _checkIfUserIsLoggedIn() {
        if(!_appSettingsService.profileEmailSignedIn.isEmpty) {
            navigationService.navigateAndSetAsContainer(viewModel: ProfileViewModel.self)
        } else {
            _getProfilesInFileManager()
        }
    }
    
    private func _getProfilesInFileManager() {
        let profiles: [ProfileStruct]? = _jsonFileManager.retrieveFromJsonFile(fileName: jsonFileConstants.profiles)
        
        if profiles == nil {
            _createDefaultProfile()
        } else {
            profiles.map { $0.forEach { profile in
                _profileList.append(Profile(email: profile.email, password: profile.password, gender: Gender.init(rawValue: profile.gender)!))
            }}
        }
    }
    
    private func _createDefaultProfile() {
        _jsonFileManager.saveToJsonFile(fileName: jsonFileConstants.profiles, data: [_defaultProfile])
        _profileList.append(Profile(email: _defaultProfile.email, password: _defaultProfile.password, gender: Gender(rawValue: _defaultProfile.gender)!))
    }
    
    private func _checkEmail(_ email: String) {
        if email.isValidEmail {
            if let profile = _profileWithMatchedEmail(email) {
                navigationService.navigate(viewModel: LoginViewModel.self, arguments: profile, animated: true)
            } else {
                navigationService.navigate(viewModel: RegisterViewModel.self, arguments: email, animated: true)
            }
        } else {
            _enterValidEmailInfo(email)
        }
    }
    
    private func _profileWithMatchedEmail(_ value: String) -> Profile? {
        return _profileList.first(where: { $0.matchesEmail(value) })
    }
    
    private func _enterValidEmailInfo(_ value: String) {
        if value.isEmpty {
            _dialogService.showInfo("Enter an email first.", informationType: .info)
        } else {
            _dialogService.showInfo("Please enter a valid email.", informationType: .bad)
        }
    }
}
