//
//  WorklistHomeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-22.
//

import SwiftUI
import CoreData

//ViewModel
class WorklistHomeViewModel: ObservableObject {
    @Published var lastOpenedList: PatientsList?
    @Published var listGroup: ListFilterEnum = .active
    var showLastList: Bool {
        return UserDefaults.standard.bool(forKey: "showLastList")
    }
    
    func getLastOpenedList() -> PatientsList?{
        if let uniqueID = UserDefaults.standard.string(forKey: "lastListSelected") {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
            request.predicate = NSPredicate(format: "uniqueID == %@", uniqueID)
            do {
                return try PersistenceController.shared.container.viewContext.fetch(request).first as? PatientsList
            } catch {print(error)}
        }
        return nil
    }
}

//View
struct WorklistHomeView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var sheetToPresent: wlHomeSheets? = nil
    @State var selectedList: PatientsList? = nil
    @ObservedObject private var model = WorklistHomeViewModel()
    
    var body: some View {
        VStack{
            
            Text("Worklists").font(.largeTitle).fontWeight(.black)
            
            HStack{
                Picker("List filter", selection: $model.listGroup) {
                    ForEach(ListFilterEnum.allCases, id:\.self){option in
                        Text(option.label).tag(option)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Spacer()
                Button(action: { self.sheetToPresent = .listFormView }) { Image(systemName:"plus") }.padding(.leading)
            }
            
            List {
                CoreDataProvider(sorting: model.listGroup.descriptors, predicate: model.listGroup.predicate) { (list: PatientsList) in
                    ListRow(list: list)
                        .onTapGesture{
                            self.selectedList = list
                            self.sheetToPresent = .selectedList
                        }
                }
            }
            .sheet(item: $sheetToPresent){ item in
                switch item {
                case .lastWorklist:
                    if let list = model.getLastOpenedList() {WorklistView(list: list)}
                case .listFormView:
                    NavigationView{ListFormView()}.environment(\.managedObjectContext, self.viewContext)
                case .selectedList:
                    if let list = selectedList {WorklistView(list: list)}
                default:
                    EmptyView()
                }
            }
        }.padding()
        .onAppear{
            if model.showLastList{self.sheetToPresent = .lastWorklist}
        }
    }
}

enum wlHomeSheets: Identifiable {
    case lastWorklist, navigator, listFormView, selectedList
    
    var id: Int { hashValue }
}



struct WorklistHomeView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistHomeView()
    }
}
