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
        Text("\(act.timestamp?.dayLabel(dateStyle: .medium) ?? "No date") - \(act.ramqCode ?? "No ramq code")")//.font(.subheadline)
    }
}

struct MedicalActRow_Previews: PreviewProvider {
    static var previews: some View {
        MedicalActRow(act: PersistenceController.singleAct)
    }
}
