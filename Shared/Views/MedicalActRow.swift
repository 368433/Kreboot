//
//  MedicalActRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-13.
//

import SwiftUI

struct MedicalActRow: View {
    var act: Act
    var body: some View {
        HStack{
            Image(systemName: "smallcircle.fill.circle")
            
            VStack (alignment: .leading){
                Text("\(act.timestamp?.dayLabel(dateStyle: .short) ?? "No date")").foregroundColor(.secondary).fontWeight(.light)
                Text( "\(act.ramqCode ?? "No ramq code")").fontWeight(.medium)
            }
            Spacer()
        }
        
    }
}

struct MedicalActRow_Previews: PreviewProvider {
    static var previews: some View {
        MedicalActRow(act: PersistenceController.singleAct)
    }
}
