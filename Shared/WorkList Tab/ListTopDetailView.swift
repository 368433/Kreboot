//
//  ListTopDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
//

import SwiftUI

struct ListTopDetailView: View {
    var list: PatientsList
    var editAction: ()->Void
    
    var body: some View{
        HStack(alignment:.center){
            Text(list.wrappedTitle).font(.title).fontWeight(.heavy).lineLimit(3)
            VStack (alignment:.leading){
                Text("Semaine du " + list.dayLabel(dateStyle: .medium)).font(.footnote)
                Text("some other useful information").font(.footnote)
            }.lineLimit(2).foregroundColor(.secondary)
            Spacer()
            Button(action: editAction){Text("Edit").font(.caption)}.buttonStyle(CapsuleButton())
        }
    }
}

struct ListTopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListTopDetailView(list: PersistenceController.singleList, editAction: {})
    }
}
