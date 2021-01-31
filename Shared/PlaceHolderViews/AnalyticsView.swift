//
//  AnalyticsView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        ScrollView{
            NavigationLink(
                destination: SecondView(),
                label: {
                    VStack {
                        Text("Navigate")
                    }
                }
            )
        }
    }
}

struct SecondView: View {
    var body: some View{
        List{
            ForEach(0..<10, id:\.self){ index in
                Text("Row number \(index)")
            }
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
