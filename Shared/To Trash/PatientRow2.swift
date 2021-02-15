////
////  PatientRow2.swift
////  Kreboot
////
////  Created by Amir Mac Pro 2019 on 2021-01-31.
////
//
//import SwiftUI
//
//struct PatientRow2: View {
//    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var patient: Patient
//    @State private var showFullCard: Bool = false
//    @ObservedObject var model: WorklistViewModel
//    
//    var body: some View {
//        HStack (alignment: .top){
//            VStack{
//                HStack (alignment: .center) {
//                    HStack {
//                        Button(action: {model.activeSheet = .showIdCard; model.selectedCard = patient}){Image(systemName: "person.crop.circle.fill").font(.title2)}
//                        Text(patient.name ?? "No name")
//                    }
//                    Spacer()
//                    Button(action: {model.activeSheet = .setDiagnosis; model.selectedCard = patient}){ Text("Diagnosis").font(.footnote)}.buttonStyle(TightOutlineButton())
//                }
//                Spacer()
//                HStack{
//                    Group{
//                        Button(action: {model.activeSheet = .editRoom; model.selectedCard = patient}){Label("room", systemImage: "bed.double")}
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 5)
//                            .background(Color.offWhite)
//                            .foregroundColor(.gray)
//                            .cornerRadius(20)
//                        Label("#00000", systemImage: "folder")
//                        Label("Last seen", systemImage: "clock")
//                    }.foregroundColor(.secondary).font(.caption).lineLimit(1)
//                }
//            }
//            Spacer()
//            Button(action: {model.activeSheet = .addAct; model.selectedCard = patient}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}.padding(.leading)
//            
//        }.padding()
//        .background(Color.white)
//        .cornerRadius(10.0)
//        .shadow(color: Color.black.opacity(0.3), radius: 5)
//        .onTapGesture {
//            showFullCard.toggle()
//        }
//        .frame(height: showFullCard ? 400:80)
//        .animation(.easeInOut(duration: 0.2))
//    }
//}
//
//struct PatientRow2_Previews: PreviewProvider {
//    static var previews: some View {
//        PatientRow2(patient: PersistenceController.singlePatient, model: WorklistViewModel())
//    }
//}
