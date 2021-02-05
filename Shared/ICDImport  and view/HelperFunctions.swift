////
////  HelperFunctions.swift
////  Kreboot (iOS)
////
////  Created by Amir Mac Pro 2019 on 2021-02-03.
////
//
//import Foundation
//
//
//struct DataGetter {
//    
//    private var data: Data?
//    private var url: String?
//    private var fileNameOnDisc: String?
//    
//    init(from url: String) {
//        self.url = url
//    }
//    
//    init(fromFile named: String){
//        self.fileNameOnDisc = named
//    }
//    
//    public func getData(completionHandler: @escaping (Error?) -> Void) -> Data? {
//        if let file = fileNameOnDisc {
//            return convertFileToData(file, completionHandler: completionHandler)
//        }
//        
//    }
//        
//        private func convertFileToData(_ sourceName: String, completionHandler: @escaping (Error?) -> Void) -> Data?  {
//            // Get file URL
//            guard let url = Bundle.main.url(forResource: sourceName, withExtension: nil) else {
//                completionHandler(DataFetchError.fileNotInBundle)
//                return nil
//            }
//            
//            // Get a data representation of JSON
//            guard let data = try? Data(contentsOf: url) else {
//                completionHandler(DataFetchError.fileCouldNotLoad)
//                return nil
//            }
//            return data
//        }
//        
//        private func dataFromURL(url source: String, completionHandler: @escaping (Error?) -> Void) -> Data? {
//            
//            var fetchedData: Data
//            
//            // Create a URL to load, and a URLSession to load it.
//            guard let fileURL = URL(string: source) else {
//                completionHandler(DataFetchError.urlError)
//                return nil
//            }
//            let session = URLSession(configuration: .default)
//            
//            // Create a URLSession dataTask to fetch the feed.
//            let task = session.dataTask(with: fileURL) { data, _, urlSessionError in
//                
//                // Alert any error returned by URLSession.
//                guard urlSessionError == nil else {
//                    completionHandler(urlSessionError)
//                    return
//                }
//                
//                // Alert the user if no data comes back.
//                guard let data = data else {
//                    completionHandler(DataFetchError.networkUnavailable)
//                    return
//                }
//                
//                fetchedData = data
//            }
//            // Start the task.
//            print("\(Date()) Start fetching data from server ...")
//            task.resume()
//            
//            return fetchedData
//        }
//        
////    public func decodeJSON(from data: Data, into object: Decodable){
////        // Decode the JSON and import it into Core Data.
////        do {
////            // Decode the JSON into codable type GeoJSON.
////            let geoJSON = try JSONDecoder().decode(GeoJSON.self, from: data)
////            print("\(Date()) Got \(geoJSON.quakePropertiesList.count) records.")
////
////            print("\(Date()) Start importing data to the store ...")
////            // Import the GeoJSON into Core Data.
////            if #available(iOS 13, macOS 10.15, *) {
////                try self.importQuakesUsingBIR(from: geoJSON)
////            } else {
////                try self.importQuakesBeforeBIR(from: geoJSON)
////            }
////            print("\(Date()) Finished importing data.")
////
////        } catch {
////            // Alert the user if data cannot be digested.
////            completionHandler(error)
////            return
////        }
////        completionHandler(nil)
////    }
////
//}
//
//
//enum DataFetchError: Error {
//    case urlError
//    case networkUnavailable
//    case wrongDataFormat
//    case missingData
//    case creationError
//    case batchInsertError
//    case batchDeleteError
//    case fileNotInBundle
//    case fileCouldNotLoad
//}
