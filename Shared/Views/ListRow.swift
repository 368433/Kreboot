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
        HStack{
            VStack(alignment:.leading){
                Text((list.title ?? "No title").localizedCapitalized).font(.subheadline)
                HStack {
                    Text("wk of " + (list.dateCreated?.dayLabel(dateStyle: .medium) ?? "")).font(.footnote)
                    Spacer()
                    Text(list.patientCountDescription).font(.footnote)
                }.foregroundColor(.secondary)
                
            }.lineLimit(1)
            Spacer()
        }.background(Color.white)
        
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: PersistenceController.singleList)
    }
}
