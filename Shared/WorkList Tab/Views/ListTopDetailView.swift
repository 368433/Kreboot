//
//  ListTopDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
//

import SwiftUI

struct ListTopDetailView: View {
    var title: String
    var details: String
    var editAction: ()->Void
    
    var body: some View{
        HStack(alignment:.center){
            Text(title).font(.title).fontWeight(.heavy).lineLimit(3)
            VStack (alignment:.leading){
                Text(details).font(.footnote)
            }.lineLimit(2).foregroundColor(.secondary)
            Spacer()
            Button(action: editAction){Text("Edit").font(.caption)}.buttonStyle(CapsuleButton())
        }
    }
}

struct ListTopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListTopDetailView(title: PersistenceController.singleList.title ?? "", details: "Semaine du \(PersistenceController.singleList.dayLabel(dateStyle: .medium))",editAction: {})
    }
}
