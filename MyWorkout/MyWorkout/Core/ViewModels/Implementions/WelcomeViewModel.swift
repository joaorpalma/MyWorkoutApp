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
    
    private var _profileList: [Profile] = []
    
    private(set) lazy var checkEmailCommand = WpCommand<String>(_checkEmail)
    
    init(dialogService: DialogService, jsonFileManager: JsonFileManager) {
        _dialogService = dialogService
        _jsonFileManager = jsonFileManager
    }
    
    override func initialize() {
        _getProfilesInFileManager()
    }
    
    private func _getProfilesInFileManager() {
        let profiles: [ProfileStruct]? = _jsonFileManager.retrieveFromJsonFile(fileName: "profiles_db")
        
        profiles.map { $0.forEach { profile in
            _profileList.append(Profile(email: profile.email, password: profile.password, gender: Gender.init(rawValue: profile.gender)!))
        }}
    }
    
    private func _checkEmail(_ email: String) {
        if (email.isValidEmail) {
            if(_isEmailRegistered(email)) {
                navigationService.navigate(viewModel: LoginViewModel.self, arguments: email, animated: true)
            } else {
                navigationService.navigate(viewModel: RegisterViewModel.self, arguments: email, animated: true)
            }
        } else {
            _enterValidEmailInfo(email)
        }
    }
    
    private func _isEmailRegistered(_ value: String) -> Bool {
        return _profileList.contains(where: { $0.matchesEmail(value) })
    }
    
    private func _enterValidEmailInfo(_ value: String) {
        if(value.isEmpty) {
            _dialogService.showInfo("Enter an email first.", informationType: .info)
        } else {
            _dialogService.showInfo("Please enter a valid email.", informationType: .bad)
        }
    }
}
