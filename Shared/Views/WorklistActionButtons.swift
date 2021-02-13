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
        VStack{
            Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}.hidden()
            Button(action: {model.activeSheet = .searchPatients}){Image(systemName: "plus.magnifyingglass")}.disabled(model.isEmpty)
            Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}.disabled(model.isEmpty)
        }.font(.title3).buttonStyle(CircularButton()).padding()
    }
}

struct WorklistActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        WorklistActionButtons(for: WorklistViewModel())
    }
}
