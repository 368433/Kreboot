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
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                ForEach(model.actList){act in
                    MedicalActRow(act: act).onTapGesture{
                        selectedAct = act
                        activeSheet = .actFormView
                    }
                }
            }
        }.border(Color.black)
    }
}

//struct ActListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActListView()
//    }
//}
