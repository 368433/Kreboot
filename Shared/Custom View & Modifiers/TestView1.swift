//
//  TestView1.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-11.
//

import SwiftUI

struct TestView1: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        VStack {
            ScrollView {
                ForEach(numbers, id: \.self) {
                    Text("\($0)")
                }.onDelete(perform: removeRows)
            }

            Button("Add Number") {
                self.numbers.append(self.currentNumber)
                self.currentNumber += 1
            }
        }.background(Color(UIColor.secondaryLabel))
    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct TestView1_Previews: PreviewProvider {
    static var previews: some View {
        TestView1()
    }
}
