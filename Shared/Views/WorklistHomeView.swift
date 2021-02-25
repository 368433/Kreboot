//
//  WorklistHomeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-22.
//

import SwiftUI
import CoreData

struct WorklistHomeView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var sheetToPresent: wlHomeSheets? = nil
    @State private var listGroup: ListFilterEnum = .active

    @State var selectedList: PatientsList? = nil
    var lastOpenedList: PatientsList? {
        if let uniqueID = UserDefaults.standard.string(forKey: "lastListSelected") {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
            request.predicate = NSPredicate(format: "uniqueID == %@", uniqueID)
            do {
                return try PersistenceController.shared.container.viewContext.fetch(request).first as? PatientsList
            } catch {print(error)}
        }
        return nil
    }

    
    var body: some View {
        VStack (alignment: .center){
            HStack {
                Text("Worklists").font(.largeTitle).fontWeight(.black)
                Spacer()
                Button(action: {self.sheetToPresent = .listFormView}){Image(systemName:"plus")}
            }.padding([.top, .horizontal])
            
            Picker("List filter", selection: $listGroup) {
                ForEach(ListFilterEnum.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)

            List {
                CoreDataProvider(sorting: listGroup.descriptors, predicate: listGroup.predicate) { (list: PatientsList) in
                    ListRow(list: list)
                        .onTapGesture{
                            self.selectedList = list
                            self.sheetToPresent = .selectedList
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .sheet(item: $sheetToPresent){ item in
                switch item {
                case .lastWorklist:
                    if let list = lastOpenedList {
                        WorklistView(list: list)
                    }
                case .listFormView:
                    NavigationView{ListFormView()}.environment(\.managedObjectContext, self.viewContext)
                case .selectedList:
                    if let list = selectedList {
                        WorklistView(list: list)
                    }
                default:
                    EmptyView()
                }
            }
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
