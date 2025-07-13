//
//  ListFormState.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//

import Foundation

class ListFormState: ObservableObject {
    @Published var listName: String = ""
    @Published var listDescription: String = ""
    @Published var listCreatedAt: String = ""
    @Published var listDueDate: Date = Date()
    @Published var listNotes: String = ""

    func resetForm() {
        listName = ""
        listDescription = ""
        listCreatedAt = ""
        listDueDate = Date()
        listNotes = ""
    }

    var isValid: Bool {
        return !listName.trimmingCharacters(in: .whitespaces).isEmpty
    }
}