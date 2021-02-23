//
//  WorklistHomeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-22.
//

import SwiftUI

struct WorklistHomeView: View {
    var patientsList: PatientsList?
    
    var body: some View {
        if let list = patientsList {
            
        } else {
            
        }
    }
}

struct WorklistHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHomeView()
    }
}
