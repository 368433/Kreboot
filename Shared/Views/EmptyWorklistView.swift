//
//  EmptyWorklistView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-13.
//

import SwiftUI

struct EmptyWorklistView: View {
    var action: ()-> Void
    var body: some View {
        HStack{
            Spacer()
            VStack (alignment: .center){
                Spacer()
                Text("No list\nSelect or create one").font(.largeTitle).fontWeight(.bold)
                Button(action:action){Image(systemName: "doc.text.magnifyingglass").font(.title2)}.buttonStyle(CircularButton(tightness: .large))
                Spacer()
            }.multilineTextAlignment(.center).foregroundColor(Color.offgray)
            Spacer()
        }
    }
}

struct EmptyWorklistView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWorklistView(action: {})
    }
}
