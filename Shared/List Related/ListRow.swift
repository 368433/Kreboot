//
//  ListRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct ListRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var list: PatientsList
    
    var body: some View {
        HStack {
            VStack(alignment:.leading){
                HStack {
                    Text((list.title ?? "No title").localizedCapitalized).fontWeight(.semibold).foregroundColor(.primary)
                    Text("wk of " + list.dayLabel(dateStyle: .medium)).font(.callout)
                }
                Text(list.patientCountDescription).font(.caption).foregroundColor(.secondary)
            }
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
//    formatter.timeStyle = .medium
    return formatter
}()

//struct ListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow()
//    }
//}
