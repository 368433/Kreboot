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
            Color.Linen.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Spacer()
                    Button(action: {sheetToPresent = .navigator}){Image(systemName: "circles.hexagongrid")}
                }
                Text("Active lists")
                Divider()
                ScrollView(.horizontal){
                    Button(action:{self.sheetToPresent = .lastWorklist}){
                        Text("Last worksheet").multilineTextAlignment(.center)
                            .frame(width: 100, height: 150, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
                            
                    }.padding().shadow(color: Color.gray.opacity(0.3),radius: 5, y: 5)
                }
                Text("Pinned lists")
                Divider()
                Spacer()
            }.padding()
            
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
            if let _ = patientsList {
                self.sheetToPresent = .lastWorklist
            }
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
