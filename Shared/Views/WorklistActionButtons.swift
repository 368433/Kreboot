//
//  WorklistActionButtons.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct WorklistActionButtons: View {
    @ObservedObject var model: WorklistViewModel
    
    @State private var expandButtons: Bool = false
    
    var animation: Animation {
        Animation.linear
    }
    
    init(for model: WorklistViewModel){self.model = model}
    
    var body: some View {
        HStack(alignment: .center){
            if expandButtons {
                Group{
                    Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}
                    Button(action: {}){Image(systemName: "arrow.up.arrow.down")}.disabled(model.isEmpty)
                    Button(action: {}){Image(systemName: "doc.text.viewfinder")}.disabled(model.isEmpty)
                    Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}.disabled(model.isEmpty)
                }.buttonStyle(CircularButton())
            }
            Button(action: {withAnimation{self.expandButtons.toggle()}}){
                Image(systemName: "chevron.left")}
                .opacity(expandButtons ? 1:0.5)
                .rotationEffect(Angle.degrees(expandButtons ? 180: 0))
                .animation(animation)
                .buttonStyle(CircularButton(tightness: .medium))
        }.padding()//.opacity(0.5)
    }
}

struct WorklistActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        WorklistActionButtons(for: WorklistViewModel())
    }
}
