//
//  JsonFileManager.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import Foundation

protocol JsonFileManager where Self: JsonFileManagerImp {
    func retrieveFromJsonFile<T: Codable>(fileName: String) -> T?
    func saveToJsonFile<T: Codable>(fileName: String, data: T)
}
