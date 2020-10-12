//
//  JsonFileManager.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import Foundation


protocol JsonFileManager {
    func retrieveFromJsonFile<T: Codable>(fileName: String) -> T?
    func saveToJsonFile(fileName: String,dict: [[String:Any]])
}