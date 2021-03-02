//
//  ActFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-12.
//

import SwiftUI

struct ActFormView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var model: AddActViewModel
    @State private var searchCodeSelecte: Bool = false
    var isShowing: Binding<Bool>?
    
    init(for act: Act?, in episode: MedicalEpisode?, isShowing: Binding<Bool>? = nil){
        self.model = AddActViewModel(act: act, episode: episode)
        self.isShowing = isShowing
    }
    
    var body: some View {
        
        VStack (alignment: .leading){
            HStack{
                Spacer()
                Button(action: saveAndDismiss){Text("Done").fontWeight(.bold)}
            }
            
            Text("Act Form").font(.largeTitle).fontWeight(.heavy)
            
            DatePicker("Date", selection: $model.actDate, displayedComponents: [.date, .hourAndMinute])
            
            VStack{
                TextField("Code", text: $model.actCode)
                    .borderedK(show: $searchCodeSelecte)
                    .onTapGesture {
                        searchCodeSelecte.toggle()
                    }
                ActCodePicker(model: model)
            }.padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(Karla.cornerRadius)
            
            TextField("Search physician db", text: $model.historyNote)
            Spacer()
        }.padding().background(Color(UIColor.secondarySystemBackground))
    }
    
    private func saveAndDismiss(){
        model.saveAct()
        if let isShowing = isShowing {
            isShowing.wrappedValue = false
        } else {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddActView_Previews: PreviewProvider {
    static var previews: some View {
        ActFormView(for: nil, in: nil)
    }
}
