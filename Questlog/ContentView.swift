//
//  ContentView.swift
//  Questlog
//
//  Created by Mars on 7/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var page: String = ""
    var body: some View {
        switch page {
        case "Lists":
            ListsView(page:$page)
        case "Projects":
            ProjectsView(page:$page)
        case "CreateList":
            ListCreationView(page:$page)
        case "ToDo":
            ToDoItemCreationView(page:$page)
        default:    
            TOCView(page:$page)
        }
    }
}

#Preview {
    ContentView()
}
