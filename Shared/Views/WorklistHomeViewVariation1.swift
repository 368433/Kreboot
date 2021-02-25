//
//  WorklistHomeViewVariation1.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-25.
//

import SwiftUI

struct WorklistHomeViewVariation1: View {
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
            default:
                WorklistHomeViewVariation2(selectedList: $selectedList)
            }
        }.onAppear(){
            // add a setting variable to determine if should auto launch
//            if let _ = patientsList {
//                self.sheetToPresent = .lastWorklist
//            }
        }
    }
}



struct WorklistHomeViewVariation1_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHomeViewVariation1()
    }
}
