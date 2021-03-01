//
//  WorklistComponentViews.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-21.
//

import SwiftUI

struct WorklistCardsList: View {
    @ObservedObject var model: WorklistViewModel
    private var episodes: [MedicalEpisode]
    
    init(model: WorklistViewModel){
        self.model = model
        self.episodes = model.getList()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                ForEach(episodes){ episode in
                    MedicalEpisodeRow(episode: episode, worklistModel: model).padding(.horizontal).onTapGesture {
                        model.selectedEpisode = episode
                        model.activeSheet = .medicalEpisodeFormView
                    }
                }
            }.padding(.top)
        }
        .emptyContent(if: episodes.isEmpty, show: "person.3", caption: "None")
    }
}

//struct WorklistHeaderButtons: View {
//    @ObservedObject var model: WorklistViewModel
//    
//    var body: some View {
//        VStack(spacing: 0){
//            
//            HStack{
//                Button(action: {model.showFilter.toggle()}) {
//                    Image(systemName: "slider.vertical.3").resizable()
//                }.scaledToFit()
//                .buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight, bgColor: model.showFilter ? Color.gray : Color.Beige, textColor: .black))
//                
//                Divider()//.frame(height: 25)
//                
//                Button(action: {model.activeSheet = .addPatient}){
//                    Image(systemName: "person.crop.circle.fill.badge.plus").resizable().scaledToFit()
//                }.scaledToFit()
//                .buttonStyle(CapsuleButton(vTightness: .tight, hTightness: .tight))
//                
//            }
////            .font(.headline)
//            .shadow(color: Color.gray.opacity(0.6), radius: 10, y: 5)
//            
//        }
//    }
//}

struct WorklistTitleHeader: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var model: WorklistViewModel
    @State private var showFilter: Bool = false
    @State private var showSort: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                Button(action:{self.presentationMode.wrappedValue.dismiss()}){Image(systemName:"xmark")}
                Spacer()
                Group{
                    Button(action: {model.activeSheet = .addPatient}){Image(systemName: "plus")}
//                    Button(action: {model.showFilter.toggle()}) {Image(systemName: "arrow.up.arrow.down")}
                    Button(action: {model.activeSheet = .editListDetails}){Image(systemName: "pencil.circle.fill")}
                }.padding(.trailing, 3)
            }.font(.title2)
            Text(model.listTitle).font(.title).fontWeight(.black).lineLimit(2).minimumScaleFactor(0.5)

            HStack{
                Text("\(model.list.listStatus.label) list").fontWeight(.light)
                Text("Week of \(model.list.dateCreated?.dayLabel(dateStyle: .medium) ?? "No date")").fontWeight(.thin)
                Text("\(model.episodesList.count) \(model.episodesList.count > 1 ? "pts":"pt")").fontWeight(.semibold)
                Text("\(model.cardsFilter.label)").fontWeight(.ultraLight).font(.caption)
            }.font(.footnote)
            
            HStack{
                Spacer()
                if showFilter{
                    Picker("Filter options", selection: $model.cardsFilter){
                        ForEach(EpisodeFilterEnum.allCases) { filter in
                            Text(filter.label).tag(filter)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .transition(.move(edge: .leading))
                }
                
                Button(action:filterPickers){Text("Filter").foregroundColor(showSort ? .secondary:Color.accentColor)}
                Divider().frame(height: 20)
                Button(action:sortPickers){Text("Sort").foregroundColor(showFilter ? .secondary:Color.accentColor)}
                if showSort{
                    Picker("Sort options", selection: $model.cardsSort){
                        ForEach(EpisodeSortEnum.allCases) { sort in
                            Text(sort.label).tag(sort)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .transition(.move(edge: .trailing))
                }
                Spacer()
            }.frame(height: 30)
        }
    }
    private func filterPickers(){
        showFilter.toggle()
        if showSort{
            showSort.toggle()
        }
    }
    private func sortPickers(){
        showSort.toggle()
        if showFilter{
            showFilter.toggle()
        }
    }
}
