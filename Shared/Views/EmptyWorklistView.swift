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
                Text("No list\nSelect one").fontWeight(.bold)
                Button(action:action){Image(systemName: "doc.text.magnifyingglass")}.buttonStyle(CircularButton())
                Spacer()
            }.multilineTextAlignment(.center).foregroundColor(Color.offgray).font(.largeTitle)
            Spacer()
        }
    }
}

struct EmptyWorklistView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWorklistView(action: {})
    }
}
