//
//  Collection.swift
//  MyWorkout
//
//  Created by João Palma on 10/10/2020.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
