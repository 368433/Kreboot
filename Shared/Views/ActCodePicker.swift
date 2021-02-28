//
//  ActCodePicker.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

struct ActCodePicker: View {
    var codeOptions: [BillCodeElement] = ["HPB", "ICM", "MGH", "GHJ", "FSDF"].map{BillCodeElement(code: $0)}
    @State var selectedOption: [String] = []
    
    let rows = [GridItem(.fixed(20)),
                GridItem(.fixed(20)),
                GridItem(.fixed(20)),
    ]
    
    var body: some View {
        HStack(alignment: .top){
            VStack{
                ForEach(selectedOption, id:\.self) { item in
                    Text(item)
                }
            }
            Divider()
            ScrollView(showsIndicators: false){
                LazyHGrid(rows: rows, content: {
                    ForEach(codeOptions){ code in
                        Text(code.code)
                            .onTapGesture {
                                selectedOption.append(code.code)
                            }
                    }
                })
            }
        }.frame(height: 200)
    }
}

struct test2: View {
    var codeOptions: [BillCodeElement] = ["HPB", "ICM", "MGH", "GHJ", "FSDF"].map{BillCodeElement(code: $0)}
    @State var selectedOption: BillCodeElement
    @State var tet = testing.test2
    
    init(){
        let test = codeOptions.first!
        self._selectedOption = State(initialValue: test)
    }
    
    var body: some View{
        Picker("test", selection: $selectedOption){
            ForEach(codeOptions) { option in
                Text(option.code).tag(option)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}

enum testing: CaseIterable, Identifiable {
    case test1, test2
    var id: Int { hashValue }
}

struct BillCodeElement: Identifiable, Hashable {
    var id = UUID()
    var code: String
}

struct ActCodePicker_Previews: PreviewProvider {
    static var previews: some View {
        ActCodePicker()
    }
}

struct test2_Previews: PreviewProvider {
    static var previews: some View {
        test2()
    }
}
