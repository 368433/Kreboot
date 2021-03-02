//
//  ActCodePicker.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

struct ActCodePicker: View {
    
    var body: some View {
        HStack(alignment: .top){
            
        }
    }
}

struct ramqAct: Codable {
    var id = UUID()
    var abbreviation: String
    var code: String
    var fee: Double
    var actDescription: String
}

struct actCategory: Codable {
    var id = UUID()
    var abbreviation: String
    var acts: [ramqAct]
}

struct actLocation: Codable {
    var id = UUID()
    var location: String
    var categories: [actCategory]
}

struct ramqActDatabase: Codable {
    var version: String
    var dateRevision: String
    var actDatabase: [actLocation]
}

enum InOutPatient { case inPatient, outPatient }
enum Building { case hospital, cabinetOutpt, urgence, cliniExt, autres }
enum ActCategory { case rout, miee, crit, opat, iNoso, transf, prophylaxis, outbreak, expoBio }
enum ActType { case vp, vc, c, vt, tw, planif, eval, eMajj1, eMajjsubseq }


struct ActCodePicker_Previews: PreviewProvider {
    static var previews: some View {
        ActCodePicker()
    }
}
