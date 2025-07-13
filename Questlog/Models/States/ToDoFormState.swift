//
//  ToDoFormState.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//

import Foundation

class ToDoFormState: ObservableObject {
    @Published var itemName: String = ""
    @Published var itemDescription: String = ""
    @Published var itemCompleted: Bool = false
    @Published var itemCreatedAt: String = ""
    @Published var itemDueDate: Date = Date()
    @Published var itemNotes: String = ""
    @Published var itemDifficulty: Int = 1

    func resetForm() {
        itemName = ""
        itemDescription = ""
        itemCompleted = false
        itemCreatedAt = ""
        itemDueDate = Date()
        itemNotes = ""
        itemDifficulty = 1
    }

    var isValid: Bool {
        return !itemName.trimmingCharacters(in: .whitespaces).isEmpty
    }
} 