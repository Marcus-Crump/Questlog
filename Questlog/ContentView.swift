//
//  ContentView.swift
//  Questlog
//
//  Created by Mars on 7/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var page: String = ""
    @StateObject private var dbManager: DBManager = DBManager()
    @StateObject private var ToDoState: ToDoFormState = ToDoFormState()
    @StateObject private var ListState: ListFormState = ListFormState()
    
    var body: some View {
        switch page {
        case "Lists":
            ListsView(page:$page, dbManager: dbManager)
        case "Projects":
            ProjectsView(page:$page)
        case "CreateList":
            ListCreationView(page:$page, dbManager: dbManager, ListState: ListState)
        case "ToDo":
            ToDoItemCreationView(page:$page, dbManager: dbManager, ToDoState: ToDoState)
        default:
            TOCView(page:$page)
        }
    }
}

#Preview {
    ContentView()
}
