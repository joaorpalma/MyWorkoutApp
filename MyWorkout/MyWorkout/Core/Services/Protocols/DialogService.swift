//
//  DialogService.swift
//  MyWorkout
//
//  Created by João Palma on 11/10/2020.
//

import Foundation

protocol DialogService {
    func showInfo(_ description: String, informationType: InfoDialogType)
}
