//
//  ListRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct ListRow: View {
    @ObservedObject var list: PatientsList
    
    var body: some View {
        // top layer of the row
        HStack{
            VStack(alignment:.leading){
                Text((list.title ?? "No title").localizedCapitalized)
                HStack {
                    Text("wk of " + (list.dateCreated?.dayLabel(dateStyle: .medium) ?? "")).font(.subheadline)
                    Spacer()
                    Text(list.patientCountDescription).font(.footnote)
                }.foregroundColor(.secondary)
                
            }.lineLimit(1)
            Spacer()
        }.background(Color(UIColor.systemBackground))
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: PersistenceController.singleList)
    }
}
