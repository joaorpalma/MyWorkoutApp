//
//  ViewModelBase.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

class ViewModelBase: ViewModel {
    let isBusy : DynamicValue<Bool> = DynamicValue<Bool>(false)
    private(set) var navigationService: NavigationService = DiContainer.resolve()

    func prepare(dataObject: Any) {}
    func initialize() {}
    func appearing() {}
    func disappearing() {}
    func backAction() {}
}
