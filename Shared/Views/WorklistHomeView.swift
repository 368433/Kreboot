//
//  WorklistHomeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-22.
//

import SwiftUI

struct WorklistHomeView: View {
    var patientsList: PatientsList?
    @State var sheetToPresent: wlHomeSheets? = nil
    @State var selectedList: PatientsList?
    
    init(patientsList: PatientsList? = nil){
        self.patientsList = patientsList
    }
    
    var body: some View {
        ZStack{
            Color.Whitesmoke.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Button(action: {sheetToPresent = .navigator}){Image(systemName: "circles.hexagongrid")}.padding()
                }
                Text("Active lists")
                Divider()
                ScrollView(.horizontal){
                    HStack{
                        WorklistCardView(bottomText: "Last worklist").onTapGesture {
                            self.sheetToPresent = .lastWorklist
                        }
                    }
                }
                Text("Pinned lists")
                Divider()
                Spacer()
            }
            
        }
        .sheet(item: $sheetToPresent) { item in
            switch item {
            case .lastWorklist:
                if let list = patientsList{
                    WorklistView(list: list)
                }
            case .navigator:
                WorklistNavigatorView(selectedList: $selectedList)
            }
        }.onAppear(){
            // add a setting variable to determine if should auto launch
//            if let _ = patientsList {
//                self.sheetToPresent = .lastWorklist
//            }
        }
    }
}


enum wlHomeSheets: Identifiable {
    case lastWorklist, navigator
    
    var id: Int { hashValue }
}

struct WorklistHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHomeView()
    }
}
