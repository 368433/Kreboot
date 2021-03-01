//
//  WorklistComponentViews.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-21.
//

import SwiftUI

struct WorklistCardsList: View {
    @ObservedObject var model: WorklistViewModel
    //private var episodes: [MedicalEpisode]
    
    init(model: WorklistViewModel){
        self.model = model
        //self.episodes = model.getList()
    }
    
    var body: some View {
        List {
//            VStack(spacing: 20){
                ForEach(model.episodesList){ episode in
                    MedicalEpisodeRow(episode: episode, worklistModel: model)
                }.onDelete(perform: model.deleteEpisode)
                
//            }.padding(.top)
        }.onAppear{model.update()}
        //.emptyContent(if: model.episodesList.isEmpty, show: "person.3", caption: "None")
    }
}

struct WorklistTitleHeader: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var model: WorklistViewModel
    @State private var showFilter: Bool = false
    @State private var showSort: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(alignment: .center){
                Text(model.listTitle).font(.largeTitle).fontWeight(.black).lineLimit(1).minimumScaleFactor(0.3)
                Spacer()
                Group{
                    Button(action: {model.activeSheet = .editListDetails}){Image(systemName: "pencil")}
                    Button(action: {model.activeSheet = .addPatient}){Image(systemName: "plus")}
                }.padding(.trailing, 5).font(.title2)
            }
            
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
                
                Button(action:filterPickers){
                    if showFilter{
                        Image(systemName: "multiply")
                    } else {
                        Text("Filter").foregroundColor(showSort ? .secondary:Color.accentColor)
                    }
                }
                Divider().frame(height: 20)
                Button(action:sortPickers){
                    if showSort{
                        Image(systemName: "multiply")
                    } else {
                        Text("Sort").foregroundColor(showFilter ? .secondary:Color.accentColor)
                    }
                }
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
