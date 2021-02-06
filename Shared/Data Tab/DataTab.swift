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
        NavigationView{
            ScrollView(){
                VStack (spacing: 20){
                    NavigationLink(
                        destination: PatientsDBView(),
                        label: {
                            DataPav(image: "person.3", title: "Patients Database")
                        }).buttonStyle(PlainButtonStyle())
                    DataPav(image: "waveform.path.ecg", title: "Dx Database")
                    DataPav(image: "bandage", title: "ICD Database")
                    DataPav(image: "cross.circle", title: "Physicians Database")
                    DataPav(image: "doc.text.below.ecg", title: "Billing codes")
                }.padding()
            }
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
