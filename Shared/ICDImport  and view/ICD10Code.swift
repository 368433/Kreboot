//
//  ICD10Code.swift
//  Kreboot (iOS)
//
//  Abstract: extension to ICD10dx entity
//
//  Created by Amir Mac Pro 2019 on 2021-02-01.
//

import CoreData

extension ICD10dx {
    /**
     Updates a icd10dx instance with an ICD dictionary if all provided keys have values
     */
    
    func update(with icd10Dictionary: [String: String]) throws {
        guard let newCode = icd10Dictionary["icd10Code"],
              let newDesc = icd10Dictionary["icd10Description"] else {
            throw ICDError.missingData
        }
        icd10Code = newCode
        icd10Description = newDesc
    }
}

// MARK: - CODABLE

/**
 A struct for decoding JSON with the following structure:

 [{
    "code" : "A000",
    "desc" : "Cholera due to vibrio cholera 01"
 }]

 Stores an array of decoded icdCodes for later use in creating ICD10dx instances
 The JSON file is found on disc, NOT retrieved through a network call
 */

struct ICDJSON: Decodable {
    private enum ICDCodingKeys: String, CodingKey {
        case icd
    }
    
    private(set) var icdCodesList = [[String: String]]()
    
    init(from decoder: Decoder) throws {
        var rootContainer = try decoder.unkeyedContainer()
        
        while rootContainer.isAtEnd == false {
            let icdEntry = try rootContainer.decode(ICDEntry.self)
            
            // Ignore invalid entry
            if !icdEntry.isValid() {
                print("Ignored: " + "code = \(icdEntry.code ?? "")")
                continue
            }
            icdCodesList.append(icdEntry.dictionary)
        }
    }
}

struct ICDEntry: Decodable {
    let code: String?
    let desc: String?
    
    func isValid() -> Bool {
        return (code != nil && desc != nil) ? true : false
    }
    
    // the keys must have the same name as the attributes of the icd entity in core data
    var dictionary: [String: String] {
        return ["icd10Code": code ?? "",
                "icd10Description": desc ?? ""]
    }
}

