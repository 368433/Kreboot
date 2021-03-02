//
//  ActCodePicker.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

struct ActCodePicker: View {
    
    @ObservedObject private var model: AddActViewModel
    
    init(model: AddActViewModel){
        self.model = model
    }
    
    var body: some View {
        VStack{
            // TODO: implement with generics
            ForEach(model.database.actDatabase){location in
                Button(action: {
                    model.actLocation = location
                    model.actCategory = nil
                    model.ramqAct = nil
                }){
                    Text(location.location)
                        .billCodePicker(comparison: model.actLocation == location)
                }
            }.HScrollEmbeded()
            
            // Category buttons
            if let location = model.actLocation {
                ForEach(location.actCategories){category in
                    Button(action: {model.actCategory = category}){
                        Text(category.abbreviation)
                            .billCodePicker(comparison: model.actCategory == category)
                    }
                }.HScrollEmbeded()
            }
            if let category = model.actCategory {
                ForEach(category.acts){act in
                    Button(action: {
                        model.ramqAct = act
                        model.actCode = act.code
                    }){
                        Text(act.abbreviation)
                            .billCodePicker(comparison: model.ramqAct == act)
                    }
                }.HScrollEmbeded()
            }
        }
    }
}

struct HScroll: ViewModifier {
    func body(content: Content) -> some View {
        ScrollView(.horizontal){
            HStack{
                content
            }
        }
    }
}
extension View {
    func HScrollEmbeded() -> some View {
        self.modifier(HScroll())
    }
}

extension Text {
    func billCodePicker(comparison: Bool) -> some View {
        self
            .font(.subheadline)
            .lineLimit(1)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(comparison ? Color.black:Color.clear))
            .padding(2)
    }
}

struct RAMQAct: Codable, Identifiable, Hashable {
    enum CodingKeys: CodingKey{
        case abbreviation, code, fee, actDescription
    }
    
    var id = UUID()
    var abbreviation: String
    var code: String
    var fee: Double
    var actDescription: String
}

struct ActCategory: Codable, Identifiable, Hashable {
    enum CodingKeys: CodingKey{
        case abbreviation, acts
    }
    
    var id = UUID()
    var abbreviation: String
    var acts: [RAMQAct]
}

struct ActLocation: Codable, Identifiable, Hashable {
    
    enum CodingKeys: CodingKey{
        case location, actCategories
    }
    
    var id = UUID()
    var location: String
    var actCategories: [ActCategory]
}

struct RAMQActDatabase: Codable {
    var version: String
    var dateRevision: String
    var actDatabase: [ActLocation]
}

enum InOutPatient { case inPatient, outPatient }
enum Building { case hospital, cabinetOutpt, urgence, cliniExt, autres }
//enum ActCategory { case rout, miee, crit, opat, iNoso, transf, prophylaxis, outbreak, expoBio }
enum ActType { case vp, vc, c, vt, tw, planif, eval, eMajj1, eMajjsubseq }


struct ActCodePicker_Previews: PreviewProvider {
    static var previews: some View {
        ActCodePicker(model: AddActViewModel(act: nil, episode: nil))
    }
}
