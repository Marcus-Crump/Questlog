//
//  ToDoView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ToDoView: View {
    @Binding var page: String
    var name: String
    // private var description: String
    // private var dueDate: Date
    // private var priority: String
    // private var status: String
    // private var notes: String
    
    var body: some View {
        ZStack {
            Color.blue
            Text("\(name)")
            BookmarksView(page:$page)
        }
        .toolbar(.hidden, for: .navigationBar)
            }
}

#Preview {
    @Previewable @State var p: String = "ToDo"
    ToDoView(page:$p,name:"ToDo")
}
