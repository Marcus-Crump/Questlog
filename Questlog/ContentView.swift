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
    @State private var listState: ListEntity? = nil
    @State private var todoState: ToDoItemEntity? = nil
    @State private var creating: Bool = false
    
    var body: some View {
        switch page {
        case "Lists":
            ListsView(page:$page, dbManager: dbManager, lst: $listState)
        case "CreateList":
            ListCreationView(page:$page, dbManager: dbManager, lst: $listState)
        case "ListDetail":
            ListDetailView(page:$page, dbManager: dbManager, lst: $listState)
        case "ToDo":
            ToDoItemCreationView(page:$page, dbManager: dbManager,
            lst: $listState, todoState: $todoState)
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
