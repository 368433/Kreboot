//
//  Models Extension.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import CoreData

// MARK: NSManagedObject Extension
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

// MARK: Medical Episodes extension
extension MedicalEpisode {
    
    public func getPatientName() -> String {
        guard let patient = self.patient else {return "No patient assigned"}
        return patient.wrappedName
    }
    
    public var wrappedRoom: String {
        return self.roomLocation ?? "No room"
    }
    
    public var wrappedDiagnosis: String {
        return self.diagnosis?.icd10Description ?? "No diagnosis"
    }
    
    public var wrappedPatientName: String {
        return self.patient?.name ?? "No patient Name"
    }
    
    public var seenToday: Bool {
        guard let acts = self.acts as? Set<Act> else {return false}
        return acts.contains{act in act.doneToday}
    }
    
    public var mostRecentAct: Act? {
        guard let acts = self.acts as? Set<Act> else {return nil}
        return acts.sorted { ($0.timestamp ?? .distantPast) > ($1.timestamp ?? .distantPast) }.first
    }
    
//    public func updateList(){
//        guard let list = self.list else {return}
////        list.update()
//    }
    
    public func actList() -> [Act] {
        guard let actSet = self.acts as? Set<Act> else {return []}
        return actSet.sorted(by: {
            guard let time0 = $0.timestamp else {return true}
            guard let time1 = $1.timestamp else {return true}
            return time0 > time1
        })
    }
}

// MARK: Extentsion - Act
extension Act {
    public var doneToday: Bool {
        guard let date = self.timestamp else {return false}
        return Calendar.current.isDateInToday(date)
    }
    
    public var shortDate: String {
        guard let date = self.timestamp else {return "No date"}
        return date.dayLabel(dateStyle: .short)
    }
}

// MARK: Extentsion - ICD10dx
extension ICD10dx {
    public var wrappedCode: String {
        icd10Code ?? "No code"
    }
    public var wrappedDescription: String {
        icd10Description ?? "No description"
    }
}

// MARK: Extentsion - Patient
extension Patient {
    public var wrappedName: String {
        name ?? "No name assigned"
    }
    public var age: Int? {
        guard let dateOfBirth = self.dateOfBirth else {return nil}
        return Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year
    }
    
    public var ageString: String {
        guard let age = self.age else {return "n/a"}
        return String(age)
    }
}

// MARK: Extentsion - PatientsList
extension PatientsList {
    
    func getEpisodeList(filteredBy filter: EpisodeFilterEnum, sortedBy sort: EpisodeSortEnum) -> [MedicalEpisode] {
        
        // Get the set of episodes
        guard let episodes = self.medicalEpisodes as? Set<MedicalEpisode> else {return []}
        
        // Filter the episodes by cardsfilter
        let filteredEpisodes: Set<MedicalEpisode> = {
            switch filter {
            case .all:
                return episodes
            case .toSee:
                return episodes.filter {!$0.seenToday}
            case .discharged:
                return episodes.filter {$0.endDate != nil}
            case .seen:
                return episodes.filter {$0.seenToday}
            }
        }()
        // Sort by sort
        
        let sorted = filteredEpisodes.sorted {first, second in
            switch sort {
            case .name:
                return first.wrappedPatientName < second.wrappedPatientName
            case .room:
                return first.roomLocation ?? "no room" < second.roomLocation  ?? "no room"
            case .date:
                return (first.startDate ?? .distantPast) < (second.startDate ?? .distantPast)
            }
        }
        // return result
        return sorted
    }
    
    public var wrappedTitle: String {
        title ?? "No title"
    }
    
    var listStatus: ListFilterEnum {
        return self.isArchived ? .archived:.active
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
