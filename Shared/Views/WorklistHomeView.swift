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
    @Published var lists: [PatientsList] = []
    @Published var selectedList: PatientsList? = nil
    @Published var sheetToPresent: wlHomeSheets? = nil
    
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
    
    func getList() -> [PatientsList] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
        request.predicate = listGroup.predicate
        request.sortDescriptors = listGroup.descriptors
        do {
            return try PersistenceController.shared.container.viewContext.fetch(request) as? [PatientsList] ?? []
        } catch {
            print(error)
        }
        return []
    }
    
    func setList() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
        request.predicate = listGroup.predicate
        request.sortDescriptors = listGroup.descriptors
        do {
            self.lists = try PersistenceController.shared.container.viewContext.fetch(request) as? [PatientsList] ?? []
        } catch {
            print(error)
        }
    }
}

//View
struct WorklistHomeView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var model = WorklistHomeViewModel()
    @State var displayMode: wlDisplayMode = .list
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Worklists").font(.largeTitle).fontWeight(.black)
                Spacer()
                Button(action:{self.displayMode = .cards}){Image(systemName: "square.grid.2x2")}
                Button(action:{self.displayMode = .list}){Image(systemName: "list.bullet")}
                Button(action: { self.model.sheetToPresent = .listFormView }) { Image(systemName:"plus") }
            }
            
            Picker("List filter", selection: $model.listGroup) {
                ForEach(ListFilterEnum.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            switch self.displayMode {
            case .list:
                SimpleListOfList(model: model)
            case .cards:
                EmptyView()
            }
            Spacer()
        }.padding()
        .onAppear{
            if model.showLastList{self.model.sheetToPresent = .lastWorklist}
        }
        .sheet(item: $model.sheetToPresent){ item in
            switch item {
            case .lastWorklist:
                if let list = model.getLastOpenedList() {WorklistView(list: list)}
            case .listFormView:
                NavigationView{ListFormView()}.environment(\.managedObjectContext, self.viewContext)
            case .selectedList:
                if let list = model.selectedList {WorklistView(list: list)}
            default:
                EmptyView()
            }
        }
    }
}

struct SimpleListOfList: View {
    @ObservedObject var model: WorklistHomeViewModel
    private var list: [PatientsList]
    
    init(model: WorklistHomeViewModel){
        self.model = model
        self.list = model.getList()
    }
    
    var body: some View {
        List {
            ForEach(list){ list in
                ListRow(list: list)
                    .onTapGesture{
                        self.model.selectedList = list
                        self.model.sheetToPresent = .selectedList
                    }
            }
        }.emptyContent(if: list.count == 0, show: "list.bullet.rectangle", caption: "No list")
    }
}

enum wlDisplayMode: Identifiable {
    case list, cards
    var id: Int {hashValue}
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
