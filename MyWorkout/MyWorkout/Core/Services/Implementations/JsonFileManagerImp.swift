//
//  jsonFileManager.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import UIKit

class JsonFileManagerImp: JsonFileManager {
    private let fileManager = FileManager.default
    
    func retrieveFromJsonFile<T: Codable>(fileName: String) -> T? {
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = documentDirectory.appendingPathComponent("\(fileName).json")
            
            guard fileManager.fileExists(atPath: url.path) else { return nil }
                
            let jsonData = try Data(contentsOf: url, options: .mappedIfSafe)
            let json = try? JSONDecoder().decode(T.self, from: jsonData)
            return json
        } catch {
            print(error)
            fatalError("Unable to read file")
        }
    }
    
    func saveToJsonFile<T>(fileName: String, data: T) where T : Decodable, T : Encodable {
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = documentDirectory.appendingPathComponent("\(fileName).json")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(data)
            
            try jsonData.write(to: url)
        } catch {
            print(error)
            fatalError("Unable to write contents to file")
        }
    }
}
