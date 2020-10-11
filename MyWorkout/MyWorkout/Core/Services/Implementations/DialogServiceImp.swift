//
//  DialogServiceImp.swift
//  MyWorkout
//
//  Created by João Palma on 11/10/2020.
//

import Foundation

class DialogServiceImp: DialogService {
    func showInfo(_ description: String, informationType: InfoDialogType) {
        let infoView = InfoDialogView()
        infoView.showInfo(text: description, infoType: informationType)
    }
}
