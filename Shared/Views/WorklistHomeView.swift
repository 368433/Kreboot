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
    
    init(patientsList: PatientsList? = nil){
        self.patientsList = patientsList
    }
    
    var body: some View {
        ZStack{
            Color.Linen
            Button(action:{self.sheetToPresent = .lastWorklist}){
                Text("Last worksheet").multilineTextAlignment(.center)
                    .frame(width: 100, height: 150, alignment: .center)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
                    .shadow(color: Color.black.opacity(0.5),radius: 10, y: 10)
            }
            
        }
        .sheet(item: $sheetToPresent) { item in
            switch item {
            case .lastWorklist:
                if let list = patientsList{
                    WorklistView(list: list)
                }
            }
        }.onAppear(){
            if let _ = patientsList {
                self.sheetToPresent = .lastWorklist
            }
        }
    }
}

enum wlHomeSheets: Identifiable {
    case lastWorklist
    
    var id: Int { hashValue }
}

struct WorklistHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHomeView()
    }
}
