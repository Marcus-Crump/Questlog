//
//  ToDoView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ToDoView: View {
   @Binding var page: Page
   @EnvironmentObject var dbManager: DBManager
   @Binding var lst: ListEntity?
   @Binding var todoState: ToDoItemEntity?
   @EnvironmentObject var history: HistoryStack
   @State private var editMode: Bool = false
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        page = history.pop() ?? .toc
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    if editMode {
                        TextField("ToDo Name", text: Binding(
                            get: { todoState?.name ?? "" },
                            set: { todoState?.name = $0 }
                        ))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 50)
                    }else {
                        Text("\(todoState?.name ?? "Error")")
                    }
                    Button(action: {
                        if let todo = todoState {
                            dbManager.updateItem(
                                todo,
                                title: todo.name ?? "",
                                description: todo.desc ?? "",
                                difficulty: Int(todo.difficulty),
                                notes: todo.notes ?? "",
                                dueDate: todo.dateDue ?? Date()
                            )
                        }
                        editMode.toggle()
                    }) {
                        Image("WriteNewThing")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                }

            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            print(history.history)
        }
            }
}

#Preview {
    ToDoView(page: .constant(.toDo), lst: .constant(nil), todoState: .constant(nil))
        .environmentObject(HistoryStack())
        .environmentObject(DBManager())
}
