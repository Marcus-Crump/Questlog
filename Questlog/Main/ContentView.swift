//
//  ContentView.swift
//  Questlog
//
//  Created by Mars on 7/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var page: Page = .toc
    @EnvironmentObject var dbManager: DBManager
    @EnvironmentObject var historyStack: HistoryStack
    @State private var listState: ListEntity? = nil
    @State private var todoState: ToDoItemEntity? = nil
    @State private var creating: Bool = false
    
    var body: some View {
        switch page {
        case .lists:
            ListsView(page:$page, lst: $listState)

        case .createList:
            ListCreationView(page:$page, lst: $listState)

        case .listDetail:
            ListDetailView(page:$page, lst: $listState, todoState: $todoState)

        case .toDo:
            ToDoItemCreationView(page:$page, lst: $listState, 
            todoState: $todoState)

        case .projects:
            ProjectsView(page:$page)

        case .settings:
            SettingsView(page: $page)
            
        default:
            TOCView(page:$page)
        }
    }
}

#Preview {
    ContentView()
}
