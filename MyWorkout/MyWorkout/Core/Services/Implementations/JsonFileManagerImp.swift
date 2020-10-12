//
//  jsonFileManager.swift
//  MyWorkout
//
//  Created by João Palma on 12/10/2020.
//

import UIKit

class JsonFileManagerImp: JsonFileManager {
    func retrieveFromJsonFile<T: Codable>(fileName: String) -> T? {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let json = try? JSONDecoder().decode(T.self, from: jsonData)
                return json
           } catch {
               print(error)
               fatalError("Unable to read contents of the file url")
           }
        } else {
            return nil
        }
    }
    
    func saveToJsonFile(fileName:String, dict:[[String:Any]]) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(fileName).json")

        let personArray = dict

        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: personArray, options: [])
            try data.write(to: fileUrl, options: [])
        } catch {
            print(error)
        }
    }
}
