////
////  ListFormState.swift
////  Questlog
////
////  Created by Mars on 7/13/25.
////
//
//import Foundation
//
//class ListFormState: ObservableObject {
//    @Published var list: ListEntity?
//
//    func resetForm() {
//        listName = ""
//        listDescription = ""
//        listCreatedAt = ""
//        listDueDate = Date()
//        listNotes = ""
//    }
//
//    var isValid: Bool {
//        return !listName.trimmingCharacters(in: .whitespaces).isEmpty
//    }
//}
