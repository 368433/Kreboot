//
//  ICDError.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-01.
//

import Foundation

enum ICDError: Error {
    case urlError
    case networkUnavailable
    case wrongDataFormat
    case missingData
    case creationError
    case batchInsertError
    case batchDeleteError
}

extension ICDError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return NSLocalizedString("Could not create URL", comment: "")
        case .networkUnavailable:
            return NSLocalizedString("Could not get data from the remote server", comment: "")
        case .wrongDataFormat:
            return NSLocalizedString("Could not digest the fetched data", comment: "")
        case .missingData:
            return NSLocalizedString("Found and will discard an ICD code missing a code or a description", comment: "")
        case .creationError:
            return NSLocalizedString("Failed to cerate a new ICDcode object", comment: "")
        case .batchInsertError:
            return NSLocalizedString("Failed to execute a batch insert request", comment: "")
        case .batchDeleteError:
            return NSLocalizedString("Failed to execute a batch delete request", comment: "")
        }
    }
}
