//
//  ActCodePicker.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

class ActCodeGenerator: ObservableObject {
//    @Published var database: RAMQActDatabase
    @Published var database: TestJSON
    
    init(){
//        self.database = RAMQActDatabase(version: 0, dateRevision: "", actDatabase: [])
        self.database = TestJSON(type: "", coordinates: "")
        self.fetchJSON{ error in
            if let error = error {
                print(error)
            }
        }
    }
    
    
    func fetchJSON(completionHandler: @escaping (Error?) -> Void) {
        //JSON file is on disk. Open it and import
//        let jsonFile = "ramqDB"
        let jsonFile = "Directions"
        
        //Get file URL from directory on disk
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: ".json") else {
            fatalError("Failed to located json file on disk")
        }
         // get a data representation of JSON
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file to data from Bundle")
        }
        
        // Decode JSON and import it
        do {
            // Decode JSON into codable type
            let ramqDB = try JSONDecoder().decode(TestJSON.self, from: data)
            database = ramqDB
        } catch {
            // Alert user data not digested
            completionHandler(error)
            return
        }

    }
}

struct ActCodePicker: View {
    
    @ObservedObject private var model = ActCodeGenerator()
    
    var body: some View {
        Text(model.database.type)
//        List{
//            ForEach(model.database.actDatabase){ location in
//                Text(location.location)
//            }
//        }
    }
}

struct TestJSON: Codable {
    var type: String
    var coordinates : String
}

struct RAMQAct: Codable, Identifiable {
    var id = UUID()
    var abbreviation: String
    var code: String
    var fee: Double
    var actDescription: String
}

struct ActCategory: Codable, Identifiable {
    var id = UUID()
    var abbreviation: String
    var acts: [RAMQAct]
}

struct ActLocation: Codable, Identifiable {
    var id = UUID()
    var location: String
    var actCategories: [ActCategory]
}

struct RAMQActDatabase: Codable {
    var version: Double
    var dateRevision: String
    var actDatabase: [ActLocation]
}

enum InOutPatient { case inPatient, outPatient }
enum Building { case hospital, cabinetOutpt, urgence, cliniExt, autres }
//enum ActCategory { case rout, miee, crit, opat, iNoso, transf, prophylaxis, outbreak, expoBio }
enum ActType { case vp, vc, c, vt, tw, planif, eval, eMajj1, eMajjsubseq }


struct ActCodePicker_Previews: PreviewProvider {
    static var previews: some View {
        ActCodePicker()
    }
}
