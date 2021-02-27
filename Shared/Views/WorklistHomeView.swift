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
                Button(action:{self.displayMode = .cards}){Image(systemName: self.displayMode == .cards ? "square.grid.2x2.fill":"square.grid.2x2")}
                Button(action:{self.displayMode = .list}){Image(systemName: self.displayMode == .list ? "rectangle.split.1x2.fill":"rectangle.split.1x2")}
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
                CardsListOfList(model: model)
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
                ListFormView().environment(\.managedObjectContext, self.viewContext)
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
        }
        .emptyContent(if: list.count == 0, show: "list.bullet.rectangle", caption: "No \(model.listGroup.label) list")
    }
}

struct CardsListOfList: View {
    @ObservedObject var model: WorklistHomeViewModel
    private var list : [PatientsList]
    static private var cardWidth: CGFloat = 180
    
    let columns = [GridItem(.fixed(cardWidth)),
                   GridItem(.fixed(cardWidth))]
    
    init(model: WorklistHomeViewModel){
        self.model = model
        self.list = model.getList()
    }
    
    var body: some View{
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: columns, alignment: .center){
                ForEach(list) { list in
                    ListCard(list: list)
                        .onTapGesture{
                            self.model.selectedList = list
                            self.model.sheetToPresent = .selectedList
                        }
                }
            }
        }
    }
}

struct ListCard: View {
    @ObservedObject var list: PatientsList
    private var cornerRadius: CGFloat = 15
    private var bgColor: Color = .Whitesmoke
    private var strokeColor: Color = .offgray
    private var height: CGFloat = 170
    
    init(list: PatientsList){
        self.list = list
    }
    
    var body: some View {
        ZStack {
            bgColor
            VStack{
                Text(list.title ?? "No title").fontWeight(.semibold)
                Spacer()
                Text(list.patientCountDescription).foregroundColor(.secondary).font(.caption)
            }.padding()
        }
        .frame(height: height)
        .cornerRadius(cornerRadius)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
        .padding()
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