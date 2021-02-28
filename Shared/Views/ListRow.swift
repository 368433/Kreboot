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
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
//        GeometryReader{ gp in
            ZStack{
                // control stack underneath top layer
                HStack{
                    Button(action: {print("test")}){
                        Text("Archive").foregroundColor(.white)
                    }.background(Rectangle().foregroundColor(.blue))
                    Spacer()
                }
                
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
                }
                .background(Color.white)
                .animation(.spring())
                .offset(x: self.dragOffset.width)
//                .gesture(DragGesture()
//                            .onChanged{ value in
//                                self.dragOffset = value.translation
//                            }
//                            .onEnded{ value in
//                                if abs(value.translation.width) > (gp.size.width * 0.4) {
//                                    self.dragOffset = value.translation
//                                } else {
//                                    self.dragOffset = .zero
//                                }
//                            })
//            }
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(list: PersistenceController.singleList)
    }
}
