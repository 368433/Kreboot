//
//  TestView1.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-11.
//

import SwiftUI

struct TestView1: View {
    @State private var showActionSheet = false

        var body: some View {
            VStack {
                Button("Show action sheet") {
                    self.showActionSheet = true
                }
            }.actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Actions"),
                    message: Text("Available actions"),
                    buttons: [
                        .cancel { print(self.showActionSheet) },
                        .default(Text("Action")),
                        .destructive(Text("Delete"))
                    ]
                )
            }
        }
}

struct TestView1_Previews: PreviewProvider {
    static var previews: some View {
        TestView1()
    }
}
