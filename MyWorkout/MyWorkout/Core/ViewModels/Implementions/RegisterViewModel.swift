//
//  RegisterViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

class RegisterViewModel: ViewModelBase {
    private let _dialogService: DialogService
    private let _jsonFileManager: JsonFileManager
    private var _appSettingsService: AppSettingsService
    
    private(set) var profileEmail: String!
    private var profileStruct = ProfileStruct()
    
    private(set) lazy var savePasswordCommand = WpCommand(_savePassword, canExecute: _canExecute)
    private(set) lazy var saveGenderCommand = WpCommand(_saveGender, canExecute: _canExecute)
    private(set) lazy var createAccountCommand = Command(_createAccount, canExecute: _canExecute)
    
    private(set) lazy var navigateBackCommand = Command(_navigateBack)
    
    init(jsonFileManager: JsonFileManager, dialogService: DialogService, appSettingsService: AppSettingsService) {
        _dialogService = dialogService
        _jsonFileManager = jsonFileManager
        _appSettingsService = appSettingsService
    }
        
    override func prepare(dataObject: Any) {
        if let email = dataObject as? String {
            profileEmail = email
            profileStruct.email = email
        } else {
            _navigateBack()
        }
    }
    
    private func _savePassword(_ password: String) {
        profileStruct.password = password
    }
    
    private func _saveGender(_ gender: Gender) {
        profileStruct.gender = gender.rawValue
    }
    
    private func _createAccount() {
        if _profileHasNoEmptyValues() {
            _registerProfile()
            _navigateToProfile()
        }
    }
    
    private func _profileHasNoEmptyValues() -> Bool {
        if (profileStruct.password.isEmpty || profileStruct.gender.isEmpty) {
            _dialogService.showInfo("Please fill in all fields", informationType: .info)
            return false
        }
        
        return true
    }
    
    private func _navigateToProfile() {
        isBusy.value = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.isBusy.value = false
            self.navigationService.navigateAndSetAsContainer(viewModel: ProfileViewModel.self)
            self._dialogService.showInfo("Account created.", informationType: .good)
        }
    }
    
    private func _registerProfile() {
        var getProfiles: [ProfileStruct] = _jsonFileManager.retrieveFromJsonFile(fileName: jsonFileConstants.profiles) ?? []
        getProfiles.append(profileStruct)
        
        _jsonFileManager.saveToJsonFile(fileName: jsonFileConstants.profiles, data: getProfiles)
        _appSettingsService.profileEmailSignedIn = profileStruct.email
    }
    
    private func _navigateBack() {
        navigationService.close(arguments: nil, animated: true)
    }
    
    private func _canExecute() -> Bool {
        !isBusy.value
    }
}
