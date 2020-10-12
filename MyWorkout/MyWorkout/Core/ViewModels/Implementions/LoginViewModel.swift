//
//  LoginViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

class LoginViewModel: ViewModelBase {
    private(set) var profileEmail = ""
    
    private(set) lazy var navigateBackCommand = Command(_navigateBack)
    
    override func prepare(dataObject: Any) {
        if let email = dataObject as? String {
            profileEmail = email
        }
    }
    
    private func _navigateBack() {
        navigationService.close(arguments: nil, animated: true)
    }
}
