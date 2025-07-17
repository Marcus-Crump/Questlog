//
//  ToDoView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ToDoView: View {
    @Binding var page: String
//    @ObservedObject var dbManager: DBManager
//    var todoState: ToDoItemEntity?
//    var lstState: ListEntity?
    var name: String
    
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
    ToDoView(page: .constant("ToDo"), name: "ToDo")
}
