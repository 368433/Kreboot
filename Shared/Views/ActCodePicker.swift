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
            Text("Code finder").smallHeader()
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
                    Button(action: {
                        model.actCategory = category
                        model.ramqAct = nil
                    }){
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
            if let act = model.ramqAct, !act.actDescription.isEmpty {
                Divider()
                Text("Description").smallHeader()
                ScrollView{
                    Text(act.actDescription)
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }.frame(maxHeight: 150)
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: Karla.cornerRadius)
                    .stroke(Color(UIColor.systemGray4)))
    }
}

struct HScroll: ViewModifier {
    func body(content: Content) -> some View {
        ScrollView(.horizontal, showsIndicators: false){
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
    func smallHeader() -> some View{
        self
            .textCase(.uppercase)
            .font(.caption2)
            .foregroundColor(Color(UIColor.darkGray))
    }
}

extension Text {
    func billCodePicker(comparison: Bool) -> some View {
        self
            .lineLimit(1)
            .font(.footnote)
            .foregroundColor(comparison ? Color.white:Color.secondary)
            .padding(6)
            .background(comparison ? Color.blue:Color.clear)
            .clipShape(Capsule())
            .overlay(Capsule().strokeBorder(comparison ? Color.clear:Color(UIColor.systemGray5)))
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
