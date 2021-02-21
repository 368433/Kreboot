//
//  WorklistComponentViews.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-21.
//

import SwiftUI

struct WorklistCardsList: View {
    var model: WorklistViewModel
    var body: some View {
        ScrollView {
            VStack{
                ForEach(model.list?.getEpisodeList(filteredBy: model.cardsFilter, sortedBy: model.cardsSort) ?? [], id:\.self){ episode in
                    MedicalEpisodeRow(episode: episode, worklistModel: model).onTapGesture {
                        model.selectedEpisode = episode
                        model.activeSheet = .medicalEpisodeFormView
                    }
                }.padding(.horizontal).padding(.vertical, 3)
            }
        }
    }
}

struct WorklistHeaderButtons: View {
    var model: WorklistViewModel
    @State private var showFilter: Bool = false
    var body: some View {
        HStack{
            Button(action: {self.showFilter.toggle()}) {Image(systemName: "slider.vertical.3")}.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: .Beige, textColor: .black))
            
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
        }
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
        }.padding().background(Color.white).cornerRadius(10).shadow(color: Color.black.opacity(0.4), radius: 5)
        .onTapGesture {
            model.activeSheet = .editListDetails
        }
    }
}
