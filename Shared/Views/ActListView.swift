//
//  ActListView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import SwiftUI

struct ActListView: View {
    
    @ObservedObject var model: ActListViewModel
    @Binding var selectedAct: Act?
    @Binding var activeSheet: ActiveSheet?
    
//    init(episode: MedicalEpisode?){
//        self.model = ActListViewModel(episode: episode)
//    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Text("Act list").font(.subheadline).fontWeight(.bold).padding(.trailing)
            ScrollView{
                VStack(alignment:.leading, spacing: 0){
                    // STRENGHTEN the foreach
                    ForEach(model.actList){act in
                        MedicalActRow(act: act).onTapGesture{
                            selectedAct = act
                            activeSheet = .actFormView
                        }
                    }
                }
            }.padding([.bottom])
        }
    }
}

//struct ActListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActListView()
//    }
//}
