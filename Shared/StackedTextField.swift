//
//  StackedTextField.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

/*
 defines a view with a label and a textfield. The label is opaque if the textfield is empty. Animates to full opacity if textfield not empty
 */

import SwiftUI
import CoreData

extension TextField {
    func labeledTF(label: String, isEmpty: Bool = true) -> some View {
        VStack(alignment: .leading, spacing: 0){
            Text(label).font(.caption).foregroundColor(.blue).opacity(isEmpty ? 0 : 1.0)
            self
        }
    }
}

extension Patient {
    public var wrappedName: String {
        name ?? "No name assigned"
    }
    
    public func saveYourself(in context: NSManagedObjectContext){
        do {
            try context.save()
        }
        catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension PatientsList {
    public var wrappedTitle: String {
        title ?? "No title"
    }
    
    public var patientCountDescription: String {
        let number = String(self.patients?.count ?? 0)
        let text = number == "0" ? "patient":"patients"
        return number + " " + text
    }
    
    public var patientsArray: [Patient] {
        let ptsList = self.patients as? Set<Patient> ?? []
        return ptsList.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public func saveYourself(in context: NSManagedObjectContext){
        do {
            try context.save()
        }
        catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


// FROM
// https://www.hackingwithswift.com/example-code/strings/how-to-capitalize-the-first-letter-of-a-string
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


struct ScrollChoice: View {
    @Binding var labelText: String
    var choice: [String]
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(choice, id:\.self) {txt in
                    Button(action: {labelText = txt}, label: {Text(txt)}).buttonStyle(TagButtonStyle())
                }
            }
        }
    }
}

struct TagButtonStyle: ButtonStyle {
    private var bgColor: Color = .yellow
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .padding(6)
            .background(configuration.isPressed ? bgColor.opacity(0.5) : bgColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
            .foregroundColor(.white)
            .clipShape(Rectangle())
            .cornerRadius(5)
    }
}

struct SomeConstants {
    static let listTitleChoice = ["Clin. Externe", "Garde", "Appels", "Micro7", "Autre"]
}
