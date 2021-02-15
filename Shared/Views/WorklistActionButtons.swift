//
//  WorklistActionButtons.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct WorklistActionButtons: View {
    @ObservedObject var model: WorklistViewModel
    init(for model: WorklistViewModel){self.model = model}
    
    var body: some View {
        HStack{
            Button(action: {}){Image(systemName: "arrow.up.arrow.down")}.disabled(model.isEmpty)
            Button(action: {}){Image(systemName: "doc.text.viewfinder")}.disabled(model.isEmpty)
            Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}.disabled(model.isEmpty)
        }.buttonStyle(CircularButton()).padding()//.opacity(0.5)
    }
}

struct WorklistActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        WorklistActionButtons(for: WorklistViewModel())
    }
}
