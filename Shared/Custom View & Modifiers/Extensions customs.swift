//
//  Extensions customs.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

private struct TempPatient: EnvironmentKey {
    static let defaultValue: Patient? = nil
}

extension EnvironmentValues {
    var tempPt: Patient? {
        get { self[TempPatient.self] }
        set { self[TempPatient.self] = newValue }
    }
}

extension View {
    func tempPt(_ tempPt: Patient?) -> some View {
        environment(\.tempPt, tempPt)
    }
}

extension Optional where Wrapped: NSSet{
    var isNull: Bool {
        if let set = self {
            return set.count == 0
        }
        return true
    }
}

extension TextField {
    func labeledTF(label: String, isEmpty: Bool = true) -> some View {
        VStack(alignment: .leading, spacing: 0){
            Text(label).font(.caption).foregroundColor(.blue).opacity(isEmpty ? 0 : 1.0)
            self
        }
    }
}

extension String {
    func sortedAlpha(_ str1: String, _ str2: String, ascending: Bool = true) -> Bool{
        return ascending ? str1 < str2 : str1 > str2
    }
}

extension Date{
    public func dayLabel(dateStyle: DateFormatter.Style) -> String {
        let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = dateStyle
            return formatter
        }()
        return itemFormatter.string(from: self)
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
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
