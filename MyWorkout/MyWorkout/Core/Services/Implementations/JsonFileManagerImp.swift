//
//  jsonFileManager.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import UIKit

final class JsonFileManagerImp: JsonFileManager {
    func saveToJsonFile<T: Codable>(fileName: String, data: T) {
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let file = directory.appendingPathComponent("\(fileName).json")
            
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: file)
        } catch {
            fatalError("Unable to write contents to file")
        }
    }
    
    func retrieveFromJsonFile<T: Codable>(fileName: String) -> T? {
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let file = directory.appendingPathComponent("\(fileName).json")
            
            guard FileManager.default.fileExists(atPath: file.path) else { return nil }
                
            let jsonData = try Data(contentsOf: file, options: .mappedIfSafe)
            let json = try JSONDecoder().decode(T.self, from: jsonData)
            return json
        } catch {
            fatalError("Unable to read file")
        }
    }
}


enum FileStore {
    func saveToJsonFile<T: Codable>(fileName: String, data: T) {
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            //iCloud
            //let iCloudDirectory = try FileManager.default.url(forUbiquityContainerIdentifier: nil)
            
            let file = directory.appendingPathComponent("\(fileName).<#fileExt#>")
            
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: file)
        } catch {
            fatalError("Unable to write contents to file")
        }
    }
    
    func retrieveFromJsonFile<T: Codable>(fileName: String) -> T? {
        do {
            let directory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let file = directory.appendingPathComponent("\(fileName).<#fileExt#>")
            
            guard FileManager.default.fileExists(atPath: file.path) else { return nil }
            
            let jsonData = try Data(contentsOf: file, options: .mappedIfSafe)
            let json = try JSONDecoder().decode(T.self, from: jsonData)
            return json
        } catch {
            fatalError("Unable to read file")
        }
    }
}

