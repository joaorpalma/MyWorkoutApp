//
//  LoginViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

final class LoginViewModel: ViewModelBase {
    private let _dialogService: DialogService
    private var _appSettingsService: AppSettingsService
    
    private(set) var profile: Profile!
    
    private(set) lazy var checkPasswordCommand = WpCommand(_checkPassword, canExecute: _canExecute)
    private(set) lazy var navigateBackCommand = Command(_navigateBack)
    
    init(dialogService: DialogService, appSettingsService: AppSettingsService) {
        _dialogService = dialogService
        _appSettingsService = appSettingsService
    }
    
    override func prepare(dataObject: Any) {
        if let profile = dataObject as? Profile {
            self.profile = profile
        } else {
            _navigateBack()
        }
    }
    
    private func _checkPassword(_ password: String) {
        if profile.passwordMatch(password) {
            _saveSignedInProfile()
            _navigateToProfile()
        } else {
            _passwordFail(password)
        }
    }
    
    private func _saveSignedInProfile() {
        _appSettingsService.profileEmailSignedIn = profile.getEmail()
    }
    
    private func _navigateToProfile() {
        isBusy.value = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isBusy.value = false
            self.navigationService.navigateAndSetAsContainer(viewModel: ProfileViewModel.self)
        }
    }
    
    private func _passwordFail(_ value: String) {
        if !value.isEmpty {
            _dialogService.showInfo("Wrong password, try again.", informationType: .bad)
        } else {
            _dialogService.showInfo("Please enter your password.", informationType: .info)
        }
    }
    
    private func _navigateBack() {
        navigationService.close(arguments: nil, animated: true)
    }
    
    private func _canExecute() -> Bool{
        !isBusy.value
    }
}
