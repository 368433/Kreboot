//
//  ActCodePicker.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

class ActCodeGenerator: ObservableObject {
    @Published var database = RAMQActDatabase(version: "", dateRevision: "", actDatabase: [])
    
    init(){
        self.fetchJSON{ error in
            if let error = error {
                print(error)
            }
        }
    }
    
    
    func fetchJSON(completionHandler: @escaping (Error?) -> Void) {
        //JSON file is on disk. Open it and import
        let jsonFile = "ramqDB"

        //Get file URL from directory on disk
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json") else {
            fatalError("Failed to located json file on disk")
        }

         // get a data representation of JSON
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file to data from Bundle")
        }

        // Decode JSON and import it
        do {
            // Decode JSON into codable type
            let ramqDB = try JSONDecoder().decode(RAMQActDatabase.self, from: data)
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
    @State private var actLocation: ActLocation
    @State private var actCategory: ActCategory
    @State private var ramqAct: RAMQAct
    
    
    var body: some View {
        VStack{
            
        }
    }
}


struct RAMQAct: Codable, Identifiable {
    enum CodingKeys: CodingKey{
        case abbreviation, code, fee, actDescription
    }
    
    var id = UUID()
    var abbreviation: String
    var code: String
    var fee: Double
    var actDescription: String
}

struct ActCategory: Codable, Identifiable {
    enum CodingKeys: CodingKey{
        case abbreviation, acts
    }
    
    var id = UUID()
    var abbreviation: String
    var acts: [RAMQAct]
}

struct ActLocation: Codable, Identifiable {
    enum CodingKeys: CodingKey{
        case location, actCategories
    }
    
    var id = UUID()
    var location: String
    var actCategories: [ActCategory]
}

struct RAMQActDatabase: Codable {
    var version: String
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
