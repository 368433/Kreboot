//
//  Karla Protocols.swift
//  MultiPlatformTest
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import Foundation
//
//protocol PatientObject {
//    var name: String {get}
//    var postalCode: String {get set}
//    var healthCardNumber: String {get set}
//    var chartNumber: String {get set}
//    var dateOfBirth: Date {get set}
//    var medicalHistory: [Diagnosis] {get set}
//    var allergies: [Allergy] {get set}
//    var episodesOfCare: [MedicalEpisode] {get set}
//}
//
//protocol MedicalEpisode {
//    var patient: PatientObject {get set}
//    var start: Date {get set}
//    var end: Date? {get set}
//    var acts: [MedicalAct] {get set}
//    var hospitalizationDate: Date? {get set}
//    var parentList: PatientList? {get set}
//}
//
//protocol MedicalAct {
//    var actDate: Date {get set}
//    var actType: String {get set}
//    var actLocation: MedicalLocation {get set}
//    var billed: Bool {get set}
//    var billable: Bool {get set}
//    var consultingPhysician: PhysicianObject? {get set}
//}
//
//protocol PhysicianObject {
//    var licenseNumber: String {get set}
//    var name: String {get set}
//}
//
//protocol PatientList {
//    var episodes: [MedicalEpisode] {get set}
//    var creationDate: Date {get set}
//}
//
//struct MedicalLocation {
//    var hospital: String?
//    var bed: String?
//    var zone: medicalZone?
//
//    enum medicalZone {
//        case inpatient, outpatientClinic, nonHospitalClinic, dialysis, ICU
//    }
//}
//
//struct Diagnosis {
//    var date: Date?
//    var icdDiagnosis: ICDCode
//}
//
//struct ICDCode {
//    var code: String
//    var description: String
//    var icdVersion: String
//}
//
//struct Allergy {
//    var substance: String
//    var dateOfOnset: String
//    private var date: Date?
//}
//
//protocol PersistentRecord {
//    func saveToDB()
//    func deleteFromDB()
//}
