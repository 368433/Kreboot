//
//  Models Extension.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import CoreData

extension NSManagedObject {
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

extension MedicalEpisode {
    public var wrappedRoom: String {
        return self.roomLocation ?? "No room"
    }
    
    public var wrappedDiagnosis: String {
        return self.diagnosis?.icd10Description ?? "No diagnosis"
    }
    
    public var wrappedPatientName: String {
        return self.patient?.name ?? "No patient Name"
    }
}

extension ICD10dx {
    public var wrappedCode: String {
        icd10Code ?? "No code"
    }
    public var wrappedDescription: String {
        icd10Description ?? "No description"
    }
}

extension Patient {
    public var wrappedName: String {
        name ?? "No name assigned"
    }
}

extension PatientsList {
    public var wrappedTitle: String {
        title ?? "No title"
    }
    
    var listStatus: [ListFilterEnum] {
        var status = [ListFilterEnum]()
        status.append(self.isArchived ? .archived:.active)
        if self.isFavorite { status.append(.favorite) }
        return status
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
}
