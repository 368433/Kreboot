//
//  WorklistHeaderView.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct WorklistHeaderView: View {
    @ObservedObject var model: WorklistViewModel
//    @State private var cardsGroup: CardsFilter = .toSee
    
    
    init(for model: WorklistViewModel){
        self.model = model
    }
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack{
                Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
                Spacer()
                Button(action: {model.activeSheet = .editListDetails}){Text("Edit")}.disabled(model.isEmpty).padding(.leading)
            }
            VStack(alignment: .leading){
                Text(model.isEmpty ? "" : model.listTitle).font(.largeTitle).fontWeight(.black).lineLimit(1).minimumScaleFactor(0.3)
                
                HStack{
                    Text(model.isEmpty ? "":"Week of \(model.list?.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")").fontWeight(.thin)
                    ForEach(model.list?.listStatus ?? [], id:\.self) { listStatus in
                        TrlnClsrBadge(name: listStatus.label, color: listStatus.tagColor)
                    }
                    Spacer()
                    Button(action: {} ){Label("Seen", systemImage: "slider.vertical.3")}.buttonStyle(CapsuleButton())
                }
            }

//            Picker("Cards filter", selection: $model.cardsFilter) {
//                ForEach(CardsFilter.allCases, id:\.self){option in
//                    Text(option.label).tag(option)
//                }
//            }.pickerStyle(SegmentedPickerStyle()).disabled(model.isEmpty)
        }.padding(.horizontal)
    }
}

struct WorklistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHeaderView(for: WorklistViewModel())
    }
}
