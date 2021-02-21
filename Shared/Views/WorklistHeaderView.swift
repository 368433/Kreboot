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
        VStack (alignment: .center, spacing:5){
            HStack{
                Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
                Spacer()
                Text(model.isEmpty ? "":"Week of \(model.list?.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")").font(.body).fontWeight(.thin)
            }
            
            Text(model.isEmpty ? "" : model.listTitle).font(.largeTitle).fontWeight(.black).lineLimit(1).minimumScaleFactor(0.7)
            
            HStack{
                Button(action: {model.activeSheet = .editListDetails}){
                    Text((model.list?.listStatus.label ?? "?Status")+" list").foregroundColor(.black)
                }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: .Azure))
                
                Divider().frame(height: 20)
                HStack{
                    Group{
                        Button(action: {self.showFilter.toggle()}) {
                            Image(systemName: "slider.vertical.3")
                        }
                    }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: .Beige, textColor: .black))
                    
                    Divider().frame(height: 20)
                    
                    Group{
                        Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}
                        Button(action: {}){Image(systemName: "doc.text.viewfinder")}
                        Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}
                    }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight))
                }
            }.font(.footnote)
            
            if showFilter{
                FilterAndSortPickerView(
                    filterFunc: {filter in
                        model.cardsFilter = filter
                    },
                    sortFunc: {sort in
                        model.cardsSort = sort
                    }
                )
//                HStack(alignment: .center){
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
//                            VStack{
//                                Text("filter".uppercased()).font(.system(size: 12)).fontWeight(.light)
//                                HStack{
//                                    ForEach(EpisodeFilterEnum.allCases, id:\.self) { filter in
//                                        Button(action: {}){Text(filter.label).font(.footnote)}.buttonStyle(OutlineCapsuleButton())
//                                    }
//                                }
//                            }
//                            Divider().frame(height: 20)
//                            VStack{
//                                Text("Sort".uppercased()).font(.system(size: 12)).fontWeight(.ultraLight)
//                                HStack{
//                                    ForEach(EpisodeFilterEnum.allCases, id:\.self) { filter in
//                                        Button(action: {}){
//                                            Text(filter.label)
//                                                .background(
//                                                    RoundedRectangle(cornerRadius: 20)
//                                                    .foregroundColor(Color.white)
//                                                )
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
                
                //                Picker("Cards filter", selection: $model.cardsFilter) {
                //                    ForEach(CardsFilter.allCases, id:\.self){option in
                //                        Text(option.label).tag(option)
                //                    }
                //                }.pickerStyle(SegmentedPickerStyle()).disabled(model.isEmpty)
            }
            
            
        }.padding(.horizontal)
    }
}

struct WorklistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHeaderView(for: WorklistViewModel())
    }
}
