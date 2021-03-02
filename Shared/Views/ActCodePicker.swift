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
        VStack(alignment: .leading){
            Text("Code finder".uppercased()).font(.caption2)
            Divider()
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
        .padding()
        .overlay(RoundedRectangle(cornerRadius: Karla.cornerRadius)
                    .stroke(Color(UIColor.systemGray4)))
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
            .lineLimit(1)
            .font(.subheadline)
            .foregroundColor(comparison ? Color.white:Color.secondary)
            .padding(6)
            .background(comparison ? Color.blue:Color.clear)
            .clipShape(Capsule())
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


struct ActCodePicker_Previews: PreviewProvider {
    static var previews: some View {
        ActCodePicker(model: AddActViewModel(act: nil, episode: nil))
    }
}
