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
            ZStack{
                Divider()
                Image(systemName: "smallcircle.fill.circle").font(.subheadline)
            }
            
            VStack (alignment: .leading){
                Text("\(act.timestamp?.dayLabel(dateStyle: .short) ?? "No date")").foregroundColor(.secondary).font(.caption)
                Text( "\(act.ramqCode ?? "No ramq code")").font(.subheadline).fontWeight(.medium)
            }.padding(.vertical,4)
            Spacer()
        }
        
    }
}

struct MedicalActRow_Previews: PreviewProvider {
    static var previews: some View {
        MedicalActRow(act: PersistenceController.singleAct)
    }
}
