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
    private var ListState: ListEntity? = nil
    private var ToDoState: ToDoItemEntity? = nil
    
    var body: some View {
        switch page {
        case "Lists":
            ListsView(page:$page, dbManager: dbManager, list: ListState)
        case "CreateList":
            ListCreationView(page:$page, dbManager: dbManager, list: ListState)
        case "ListDetail":
            ListDetailView(page:$page, dbManager: dbManager, list: ListState)
        case "ToDo":
            ToDoItemCreationView(page:$page, dbManager: dbManager, ToDoState: ToDoState)
        case "Projects":
            ProjectsView(page:$page)
        default:
            TOCView(page:$page)
        }
    }
}

#Preview {
    ContentView()
}
