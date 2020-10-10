//
//  ViewModel.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

protocol ViewModel {
    func prepare(dataObject: Any)
    func initialize()
    func appearing()
    func disappearing()
}
