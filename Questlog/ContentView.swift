//
//  ContentView.swift
//  Questlog
//
//  Created by Mars on 7/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var page: String = "TOC"

    var body: some View {
        switch page {
        case "TOC":
            TOCView(page:$page)
        case "Lists":
            ListsView(page:$page)
        case "ToDo":
            ToDoView(page:$page,name: "list 1")
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
