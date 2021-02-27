//
//  ListFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct ListFormView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: ListFormViewModel
    @State private var textfieldsSelected: Bool = false
    @State private var descriptionSelected: Bool = false
    private var blankForm: Bool
    
    init(list: PatientsList? = nil ){
        self.viewModel = ListFormViewModel(list: list)
        blankForm = list != nil ? false:true
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            HStack{
                Text(blankForm ? "Create New List":"Edit List").font(.largeTitle).fontWeight(.heavy)
                Spacer()
                Button(action:{
                    viewModel.save()
                    self.presentationMode.wrappedValue.dismiss()
                }){Text("Save")}.disabled(!viewModel.formIsValid)
            }.padding()
            
            HStack{
                Spacer()
                Button(action:{viewModel.isPinned.toggle()}){Image(systemName: viewModel.isPinned ? "pin.fill":"pin")}
                Button(action:{viewModel.isArchived.toggle()}){Image(systemName: viewModel.isArchived ? "archivebox.fill":"archivebox")}.padding(.horizontal)
            }.font(.title3)
            
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("List title".uppercased()).foregroundColor(.secondary).font(.caption)
                        TextField("", text: $viewModel.title)
                            .lightForm(show: $textfieldsSelected)
                            .onTapGesture {
                                self.textfieldsSelected = true
                                self.descriptionSelected = false
                            }
                    }.padding([.horizontal])
                        
                    HStack {
                        Text("Sugg.: ").font(.caption2).foregroundColor(.secondary)
                        ScrollChoice(labelText: $viewModel.titleSuggestion, choice: SomeConstants.listTitleChoice )
                    }
                    
                    VStack(alignment: .leading){
                        Text("List description".uppercased()).foregroundColor(.secondary).font(.caption)
                        ZStack{
                            RoundedRectangle(cornerRadius: Karla.cornerRadius)
                                .frame(height: 120)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: Karla.cornerRadius).stroke(Color.gray.opacity(Karla.strokeOpacity), lineWidth: 0.5))
                                .shadow(color: Color.gray.opacity(descriptionSelected ? Karla.shadowOpacity:0), radius: 5, x: 0, y: 3)
                            TextEditor(text: $viewModel.listDescription)
                                .padding(10)
                                .font(.callout)
                                .onTapGesture {
                                    self.descriptionSelected = true
                                    self.textfieldsSelected = false
                                }
                        }
                    }.padding()
                    
                    DatePicker("Date created", selection: $viewModel.date, displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
                    
                }.padding(.horizontal)
            }
        }.animation(.default)
    }
}
struct LightForm: ViewModifier {
    var highlightField: Binding<Bool>
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(Karla.strokeOpacity), lineWidth: 0.5))
            .shadow(color: Color.gray.opacity(highlightField.wrappedValue ? 0.3:0), radius: 5, x: 0, y: 3)
    }
}

extension View {
    func lightForm(show: Binding<Bool>) -> some View {
        self.modifier(LightForm(highlightField: show))
    }
}

struct ListFormView_Previews: PreviewProvider {
    static var previews: some View {
        ListFormView()
    }
}
