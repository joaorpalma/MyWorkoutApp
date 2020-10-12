//
//  Enums.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import UIKit

enum FormAlignment {
    case top, center
}

enum Gender: String {
    case Male = "Male"
    case Female = "Female"
}

enum InfoDialogType {
    case good
    case bad
    case info
}

extension InfoDialogType: RawRepresentable {
    typealias RawValue = UIColor

    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.Theme.green: self = .good
        case UIColor.Theme.red: self = .bad
        case UIColor.Theme.yellow: self = .info
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .good: return UIColor.Theme.green
        case .bad: return UIColor.Theme.red
        case .info: return UIColor.Theme.yellow
        }
    }
}
