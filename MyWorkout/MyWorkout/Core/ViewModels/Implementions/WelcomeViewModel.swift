//
//  WelcomeViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

class WelcomeViewModel: ViewModelBase {
    private let _dialogService: DialogService
    
    private(set) lazy var checkEmailCommand = WpCommand<String>(_checkEmail)
    
    init(dialogService: DialogService) {
        _dialogService = dialogService
    }
    
    override func initialize() {
        //register "registered@email.com" "password"
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
        true
    }
    
    private func _enterValidEmailInfo(_ value: String) {
        if(value.isEmpty) {
            _dialogService.showInfo("Enter an email first.", informationType: .info)
        } else {
            _dialogService.showInfo("Please enter a valid email.", informationType: .bad)
        }
    }
}
