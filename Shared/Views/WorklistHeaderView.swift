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
        VStack (alignment: .center){
            HStack{
                Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
                Spacer()
            }
            WorklistTitleHeader(model: model)
            
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
            }.font(.footnote)
            
            if showFilter{
                FilterAndSortPickerView(startingFilter: model.cardsFilter, startingSort: model.cardsSort,
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

struct WorklistTitleHeader: View {
    var model: WorklistViewModel
    var body: some View {
        VStack{
            Text(model.isEmpty ? "" : model.listTitle).font(.largeTitle).fontWeight(.heavy).lineLimit(2).minimumScaleFactor(0.5)
            HStack{
                Text((model.list?.listStatus.label ?? "?Status")+" list").fontWeight(.thin)
                Text(" - ")
                Text(model.isEmpty ? "":"Week of \(model.list?.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")").fontWeight(.thin)
            }
        }.padding().background(Color.white).cornerRadius(10).shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)
        .onTapGesture {
            model.activeSheet = .editListDetails
        }
    }
}

struct WorklistHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHeaderView(for: WorklistViewModel())
    }
}
