//
//  ListDetailView.swift
//  Questlog
//
//  Created by M on 7/16/25.
//

import Foundation
import SwiftUI

struct ListDetailView: View {
    @Binding var page: Page
    @EnvironmentObject var dbManager: DBManager
    @EnvironmentObject var historyStack: HistoryStack
    @Binding var lst: ListEntity?
    @Binding var todoState: ToDoItemEntity?
    @State var editMode: Bool = false

    var body: some View{
        ZStack {
            Background()
            VStack(spacing: 10){
                
                HStack{
                    Spacer()
                    Button(action: {
                        lst = nil
                        page = historyStack.pop() ?? .lists
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.black)
                            .padding(.top, 50)
                    }

                    if editMode {
                        TextField("List Name", text: Binding(
                            get: { lst?.name ?? "" },
                            set: { lst?.name = $0 }
                        ))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 50)
                            .frame(width: 165)
                    } else {
                        Text(lst?.name ?? "Error")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 50)
                    }

                        Button(action: {
                            if editMode {
                                if let list = lst {
                                    dbManager.updateList(list, name: list.name ?? "",
                                    description: list.desc ?? "", 
                                    notes: list.notes ?? "", 
                                    priority: list.priority)
                                }
                            }
                            editMode.toggle()
                        }) {
                        Image("WriteNewThing")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(.top, 50)
                    }

                    Button(action: {
                        historyStack.push(.listDetail)
                        page = .toDo
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(.top, 25)
                    }
                    .disabled(editMode)
                Spacer()
                }
                Spacer()

                ForEach(Array(lst?.items as? Set<ToDoItemEntity> ?? []), id: \.self) { item in
                HStack {
                    if editMode {
                    Button(action: {
                        dbManager.deleteItem(item)
                    }) {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    }
                    Button(action: {
                        todoState = item
                        historyStack.push(.listDetail)
                        page = .toDo
                    }) {
                        Text(item.name ?? "")
                    }
                }
                }

            }
        }
        .onAppear {
            print(historyStack.history)
        }
    }
}

#Preview {
    @State var testList: ListEntity? = {
        let listContext = PersistenceController.preview.container.viewContext
        let lst = ListEntity(context: listContext)
        lst.name = "Test List"
        lst.desc = "Test Description"
        lst.notes = "Test Notes"
        return lst
    }()
    @State var testTodo: ToDoItemEntity? = {
        let todoContext = PersistenceController.preview.container.viewContext
        let todo = ToDoItemEntity(context: todoContext)
        todo.name = "Test ToDo"
        todo.difficulty = 1
        todo.comTime = 1
        todo.desc = "Test Description"
        todo.notes = "Test Notes"
        todo.dateDue = Date()
        todo.list = testList
        return todo
    }()
    return ListDetailView(page: .constant(.listDetail), lst: $testList, todoState: $testTodo)
        .environmentObject(DBManager())
        .environmentObject(HistoryStack())
}
