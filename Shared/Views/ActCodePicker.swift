//
//  ActCodePicker.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

struct ActCodePicker: View {
    var codeOptions: [BillCodeElement] = ["HPB", "ICM", "MGH", "GHJ", "FSDF"].map{BillCodeElement(code: $0)}
    @State var selectedOption: [String] = []
    
    let rows = [GridItem(.fixed(20)),
                GridItem(.fixed(20)),
                GridItem(.fixed(20)),
    ]
    
    var body: some View {
        HStack(alignment: .top){
            
        }
    }
}

struct ramqAct{
    var inOutPatient: String
    var building: String
    var actCategory: String
    var actType: String
    var code: String
    var fee: Double
}

enum InOutPatient { case inPatient, outPatient }
enum Building { case hospital, cabinetOutpt, urgence, cliniExt, autres }
enum ActCategory { case rout, miee, crit, opat, iNoso, transf, prophylaxis, outbreak, expoBio }
enum ActType { case vp, vc, c, vt, tw, planif, eval, eMajj1, eMajjsubseq }


struct BillCodeElement: Identifiable, Hashable {
    var id = UUID()
    var code: String
}

struct ActCodePicker_Previews: PreviewProvider {
    static var previews: some View {
        ActCodePicker()
    }
}
