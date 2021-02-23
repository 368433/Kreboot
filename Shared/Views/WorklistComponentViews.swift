//
//  WorklistComponentViews.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-21.
//

import SwiftUI

struct WorklistCardsList: View {
    @ObservedObject var model: WorklistViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                ForEach(model.getList()){ episode in
                    MedicalEpisodeRow(episode: episode, worklistModel: model).padding(.horizontal, 30).onTapGesture {
                        model.selectedEpisode = episode
                        model.activeSheet = .medicalEpisodeFormView
                    }
                }
            }.padding(.top, 150)
        }
    }
}

struct WorklistHeaderButtons: View {
    @ObservedObject var model: WorklistViewModel
    @State private var showFilter: Bool = false
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Button(action: {self.showFilter.toggle()}) {
                    Image(systemName: "slider.vertical.3")
                }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: showFilter ? Color.gray : Color.Beige, textColor: .black))
                
                Divider().frame(height: 20)
                
                Button(action: {model.activeSheet = .addPatient}){
                    Image(systemName: "person.crop.circle.badge.plus")
                }.buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight))
                
            }.font(.headline).shadow(color: Color.gray.opacity(0.6), radius: 10, y: 5)
            
            if showFilter {
                Spacer()
                FilterAndSortPickerView(
                    startingFilter: model.cardsFilter,
                    startingSort: model.cardsSort,
                    filterFunc: {filter in model.cardsFilter = filter},
                    sortFunc: {sort in model.cardsSort = sort}
                )
                .transition(.move(edge: .bottom))
            }
        }.animation(.easeIn(duration: 0.15))
    }
}

struct WorklistTitleHeader: View {
    @ObservedObject var model: WorklistViewModel
    var body: some View {
        ZStack (alignment:.topTrailing){
            Color.white.shadow(color: Color.gray.opacity(0.4),radius: 8, y:7)
            VStack(spacing:0){
                Text(model.listTitle).font(.title).fontWeight(.black).lineLimit(2).minimumScaleFactor(0.5)
                HStack{
                    Text("\(model.list.listStatus.label) list").fontWeight(.ultraLight)
                    Divider().frame(height: 8)
                    Text("Week of \(model.list.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")").fontWeight(.thin)
                }.font(.footnote)
                Divider()
                HStack(alignment: .center){
                    Spacer()
                    Text("\(model.episodesList.count) \(model.episodesList.count > 1 ? "pts":"pt")").fontWeight(.black)
                    Text("\(model.cardsFilter.label)").fontWeight(.ultraLight).font(.caption)
                    Spacer()
                }
            }.padding([.horizontal, .top]).padding(.top)//.background(Color.white)
            Button(action: {model.activeSheet = .editListDetails}){Text("Edit")}.padding()
        }.frame(height: 112)
    }
}
