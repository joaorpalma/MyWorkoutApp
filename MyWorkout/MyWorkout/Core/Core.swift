//
//  Core.swift
//  MyWorkout
//
//  Created by João Palma on 09/10/2020.
//

struct Core {
    static func initialize() {
        _registerServices()
        _registerViewModels()
        _registerViewControllers()
        _startApp()
    }

    private static func _registerServices() {
        DiContainer.registerSingleton(NavigationService.self, constructor: { NavigationServiceImp() })
        DiContainer.registerSingleton(DialogService.self, constructor: { DialogServiceImp() })
    }

    private static func _registerViewModels() {
        DiContainer.register(WelcomeViewModel.self, constructor: { WelcomeViewModel(dialogService: DiContainer.resolve()) })
        DiContainer.register(RegisterViewModel.self, constructor: { RegisterViewModel() })
        DiContainer.register(LoginViewModel.self, constructor: { LoginViewModel() })
        DiContainer.register(ProfileViewModel.self, constructor: { ProfileViewModel() })
    }

    private static func _registerViewControllers() {
        DiContainer.registerViewController(WelcomeViewModel.self, constructor: { WelcomeViewController() })
        DiContainer.registerViewController(RegisterViewModel.self, constructor: { RegisterViewController() })
        DiContainer.registerViewController(LoginViewModel.self, constructor: { LoginViewController() })
        DiContainer.registerViewController(ProfileViewModel.self, constructor: { ProfileViewController() })
    }

    private static func _startApp() {
        let navigationService: NavigationService = DiContainer.resolve()
        navigationService.navigateAndSetAsContainer(viewModel: WelcomeViewModel.self)
    }
}
