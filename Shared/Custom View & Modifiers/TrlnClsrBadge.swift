//
//  TrlnClsrBadge.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-13.
//

import SwiftUI

struct TrlnClsrBadge: View {
    var name: String
    var color: Color = .blue
    var type: BadgeType = .normal
    var fontWeight: Font.Weight = .regular
    
    enum BadgeType {
        case normal
        case removable(()->())
    }
    
    var body: some View {
        HStack{
            // Badge Label
            Text(name)
                .fontWeight(fontWeight)
            
            // Add 'x' if removable, and setup tap gesture
            switch type {
                case .removable( let callback):
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 8, height: 8, alignment: .center)
                        .font(Font.caption.bold())
                        .onTapGesture {
                            callback()
                        }
                default:
                    EmptyView()
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(color)
        .cornerRadius(20)
    }
}

struct BadgeExample: View {
    @State var filters: [String] = [
    "SwiftUI", "Programming", "iOS", "Mobile Development", "😎"
    ]
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(filters, id: \.self) { filter in
                    TrlnClsrBadge(name: filter, color: Color(red: 228/255, green: 237/255, blue: 254/255), type: .removable({
                        withAnimation {
                            self.filters.removeAll { $0 == filter }
                        }
                    }))
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct BadgeExample_Previews: PreviewProvider {
    static var previews: some View {
        BadgeExample()
    }
}
struct TrlnClsrBadge_Previews: PreviewProvider {
    static var previews: some View {
        TrlnClsrBadge(name: "test")
    }
}
