//
//  AddPatientToListView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct AddPatientToListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @FetchRequest(entity: Patient.entity(), sortDescriptors: [])
    private var patients: FetchedResults<Patient>
    
    @State private var searchText: String = ""
    var list: PatientsList
       
    var body: some View {
        VStack{
            SearchBar(text: $searchText)
                .padding([.top, .bottom])
            List(patients.filter({searchText.isEmpty ? true : $0.wrappedName.lowercased().contains(searchText.lowercased())})){ patient in
                PatientRowAddView(patient: patient, list: list)
            }
        }
    }
    
    private func addPatientToList(offsets: IndexSet){
//        list.addToPatients(<#T##value: Patient##Patient#>)
    }
}

//struct AddPatientToListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPatientToListView()
//    }
//}
