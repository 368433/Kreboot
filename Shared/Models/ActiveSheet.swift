//
//  ActiveSheet.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case addAct, showAllLists, addPatient, searchPatients, editRoom, setDiagnosis, showIdCard, editListDetails, actFormView
    
    var id: Int {
        hashValue
    }
}
