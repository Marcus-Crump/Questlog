//
//  ToDoItemCreationView.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//

import SwiftUI

struct ToDoItemCreationView: View {
    @Binding var page: String
    @ObservedObject var dbManager: DBManager
    @ObservedObject var ToDoState: ToDoFormState
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var itemCompleted = false
    @State private var itemCreatedAt = GetCreationDate()
    @State private var itemDueDate = Date()
    @State private var itemNotes = ""
    @State private var itemDifficulty = 0

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack {
                
            }
        }
    }
}

func GetCreationDate() -> String {
    let format = DateFormatter()
    format.dateStyle = .long
    return format.string(from: Date())
}
