//
//  WorklistViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import SwiftUI

class WorklistViewModel: ObservableObject {
    @Published var list: PatientsList? = nil
    @Published var selectedCard: Patient? = nil
    @Published var activeSheet: ActiveSheet? = nil
}
