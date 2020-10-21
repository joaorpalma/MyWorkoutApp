//
//  NavigationService.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

protocol NavigationService where Self: NavigationServiceImp {
    func navigate<TViewModel: ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool)
    func navigateAndSetAsContainer<TViewModel: ViewModel>(viewModel: TViewModel.Type)
    func close(arguments: Any?, animated: Bool)
}
