//
//  ICDdbTable.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-01.
//

import SwiftUI

struct ICDdbTable: View {
    
    @ObservedObject var icdProvider = ICDProvider2()
    
    var body: some View {
        LazyVStack{
            List(icdProvider.icdResultList, rowContent: ICDTableRow.init)
            Spacer()
        }
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                HStack{
                    Button(action:{}){Image(systemName: "trash")}
                    Spacer()
                    Button(action:{}){Image(systemName: "arrow.clockwise")}
                }
            }
        })
    }
}

struct ICDTableRow: View {
    var icdResult: ICDResult
    var body: some View{
        VStack(alignment:.leading){
            Text(icdResult.icdDescription)
            Text(icdResult.icdCode)
            Divider()
        }
    }
}

struct ICDdbTable_Previews: PreviewProvider {
    static var previews: some View {
        ICDdbTable()
    }
}
