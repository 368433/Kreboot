//
//  WorklistHeaderView.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct WorklistHeaderView: View {
    @ObservedObject var model: WorklistViewModel
    
    @State private var showFilter: Bool = false
    @State private var showSort: Bool = false
    
    init(for model: WorklistViewModel){
        self.model = model
    }
    
    var body: some View{
        VStack(alignment: .leading) {
            HStack{
                Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
                Spacer()
                Text(model.isEmpty ? "":"Week of \(model.list?.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")").font(.body).fontWeight(.thin)
            }
            
            VStack(spacing:5){
                Text(model.isEmpty ? "" : model.listTitle).font(.largeTitle).fontWeight(.black).lineLimit(1).minimumScaleFactor(0.3)
                
                HStack{
                    Button(action: {model.activeSheet = .editListDetails}){
                        Text((model.list?.listStatus.label ?? "?Status")+" list").foregroundColor(.black)
                    }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: .yellow))
                    
                    Divider().frame(height: 20)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Group{
                                Button(action: {withAnimation{self.showFilter.toggle()}}) {
                                    Image(systemName: "slider.vertical.3")
                                }
                                Button(action: {}){Image(systemName: "arrow.up.arrow.down")}
                            }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: .Beige, textColor: .black))
                            
                            Divider().frame(height: 20)
                            
                            Group{
                                Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}
                                Button(action: {}){Image(systemName: "doc.text.viewfinder")}
                                Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}
                            }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight))
                        }
                    }
                }
            }
            
            if showFilter{
                Picker("Cards filter", selection: $model.cardsFilter) {
                    ForEach(CardsFilter.allCases, id:\.self){option in
                        Text(option.label).tag(option)
                    }
                }.pickerStyle(SegmentedPickerStyle()).disabled(model.isEmpty)
            }
            
            
        }.padding(.horizontal).font(.caption)
    }
}

struct WorklistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHeaderView(for: WorklistViewModel())
    }
}
