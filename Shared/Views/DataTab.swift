//
//  DataTab.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-05.
//

import SwiftUI

struct DataTab: View {
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: nil, alignment: .center),
    ]
    
    
    var body: some View {
        ScrollView(){
            VStack (alignment: .leading, spacing: 20){
                Text("Work databases").font(.title).fontWeight(.black)
                //Divider()
                NavigationLink(destination: PatientsDBView(), label: {DataViews.ptDatabse.tabView})
                NavigationLink(destination: EmptyView(), label: {DataViews.dxDatabase.tabView})
                NavigationLink(destination: EmptyView(), label: {DataViews.locationDatabse.tabView})
                
                Divider()
                Text("External Databases").font(.title).fontWeight(.black).padding(.top)
                
                NavigationLink(destination: EmptyView(), label: {DataViews.icdDatabse.tabView})
                NavigationLink(destination: EmptyView(), label: {DataViews.mdDatabase.tabView})
                NavigationLink(destination: EmptyView(), label: {DataViews.billingCodesDatabse.tabView})
            }.padding(.horizontal).buttonStyle(PlainButtonStyle())
        }
    }
}

enum DataViews: CaseIterable {
    case ptDatabse, dxDatabase, icdDatabse, mdDatabase, billingCodesDatabse, locationDatabse
    
    var tabView: some View {
        switch self {
        case .ptDatabse:
            return DataPav(image: "person.3", title: "Patients Database")
        case .dxDatabase:
            return DataPav(image: "waveform.path.ecg", title: "Dx Database")
        case .icdDatabse:
            return DataPav(image: "bandage", title: "ICD Database")
        case .mdDatabase:
            return DataPav(image: "cross.circle", title: "Physicians Database")
        case .billingCodesDatabse:
            return DataPav(image: "doc.text.below.ecg", title: "Billing codes")
        case .locationDatabse:
            return DataPav(image: "mappin.and.ellipse", title: "Work locations")
        }
    }
}

struct DataPav: View {
    var image: String
    var title: String
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.yellow)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            Label(title ,systemImage: image).padding().font(.headline)
        }
    }
    
}

struct DataTab_Previews: PreviewProvider {
    static var previews: some View {
        DataTab()
    }
}
