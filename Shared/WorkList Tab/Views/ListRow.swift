//
//  ListRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct ListRow: View {
//    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var list: PatientsList
    
    var body: some View {
        HStack {
            Image(systemName: "rectangle.stack.person.crop").scaledToFit().font(.title).foregroundColor(.secondary)
            VStack(alignment:.leading){
                HStack {
                    Text((list.title ?? "No titlexxx").localizedCapitalized).fontWeight(.semibold).foregroundColor(.primary)
                    Text("wk of " + list.dayLabel(dateStyle: .medium)).font(.footnote)
                }
                Text(list.patientCountDescription).font(.footnote).foregroundColor(.secondary)
            }.lineLimit(1)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: PersistenceController.singleList)
    }
}
