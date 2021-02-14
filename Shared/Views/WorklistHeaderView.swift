//
//  WorklistHeaderView.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct WorklistHeaderView: View {
    @ObservedObject var model: WorklistViewModel
    @State private var cardsGroup: CardsFilter = .toSee
    init(for model: WorklistViewModel){self.model = model}
    
    var body: some View{
        VStack(alignment: .leading) {
            Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(model.isEmpty ? "" : model.listTitle).font(.largeTitle).fontWeight(.black).lineLimit(1).minimumScaleFactor(0.3)
                    Text(model.isEmpty ? "":"Week of \(model.list?.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")")
                }
                Spacer()
                VStack (alignment: .trailing){
                    Button(action: {model.activeSheet = .editListDetails}){Text("Edit")}.buttonStyle(CapsuleButton()).disabled(model.isEmpty)
                    //Button(action: {model.activeSheet = .showAllLists}){Text("Open...").font(.caption)}.buttonStyle(CapsuleButton())
                    Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}.buttonStyle(CircularButton(tightness: .tight))
                }.font(.caption).padding(.leading)
            }
            Picker("Cards filter", selection: $cardsGroup) {
                ForEach(CardsFilter.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle()).disabled(model.isEmpty)
        }.padding(.horizontal)
    }
}

struct WorklistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHeaderView(for: WorklistViewModel())
    }
}
