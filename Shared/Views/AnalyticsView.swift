//
//  AnalyticsView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct AnalyticsView: View {
    
    @FetchRequest(entity: MedicalEpisode.entity(), sortDescriptors: [])
    private var cdList: FetchedResults<MedicalEpisode>
    
    var body: some View {
        Text("\(cdList.count)")
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
