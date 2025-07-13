//
//  ToDoItem.swift
//  Questlog
//
//  Created by Mars on 7/12/25.
//

import Foundation

struct ToDoItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completed: Bool
    var createdAt: Date
    var dueDate: Date
    var etc: Int
    var difficulty: Int
    var notes: String

    init(title: String, description: String, completed: Bool, createdAt: Date, 
    dueDate: Date, etc: Int, difficulty: Int, notes: String) {
        self.title = title
        self.description = description
        self.completed = completed
        self.createdAt = createdAt
        self.dueDate = dueDate
        self.etc = etc
        self.difficulty = difficulty
        self.notes = notes
    }
}