//
//  DiagnosisSearchView.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-14.
//

import SwiftUI

struct DiagnosisSearchView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var model: DiagnosisSearchViewModel
    
    init(episode: MedicalEpisode?){
        self.model = DiagnosisSearchViewModel(episode: episode)
    }
    
    var body: some View {
        VStack(alignment:.leading){
            Text("ICD search").font(.largeTitle).fontWeight(.heavy).padding([.top, .leading])
            SearchBar(text: $model.searchString).padding()
            List{
                ForEach(model.searchResults){ icd in
                    VStack (alignment: .leading){
                        Text(icd.wrappedCode)
                        Text(icd.wrappedDescription)
                    }.onTapGesture{
                        model.assignToEpisode(diagnosis: icd)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
