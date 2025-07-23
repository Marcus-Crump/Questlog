//
//  ListCreationView.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//

import SwiftUI
import Foundation

struct ListCreationView: View {
    @Binding var page: Page
    @EnvironmentObject var dbManager: DBManager
    @Binding var lst: ListEntity?
    @EnvironmentObject var history: HistoryStack

    private var duplicateListExists: Bool {
        let request = ListEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", lst?.name ?? "")
        if let results = try? dbManager.container.viewContext.fetch(request) as [ListEntity] {
            return results.contains(where: { $0 != lst })
        }
        return false
    }
    
    private var validName: Bool {
        
        if let l = lst {
            let strip: String = l.name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            // Allow "New List" as a valid name during creation, but check for duplicates otherwise
            return strip.count > 0 && !duplicateListExists
        }
        return false
    }

    var body: some View {
        ZStack {
            Background()
            VStack(spacing: 10) {
                HStack{
                    Spacer()
                    Button(action: {
                        if let l = lst {
                            dbManager.deleteList(l)
                            lst = nil
                        }
                        page = history.pop() ?? .toc
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.black)
                            .padding(.top, 50)
                    }
                Text("Create a new list")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)
                Spacer()
                }
                VStack() {
                    if duplicateListExists {
                        Text("List name already exists")
                            .font(.headline)
                            .foregroundColor(.red)
                    }
                    TextField("Enter list name...", text: Binding (
                        get: { lst?.name ?? "" },
                        set: { lst?.name = $0 }
                    )) // Placeholder text disappears when typing
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                        .frame(width: 300)
                        .padding(.horizontal, 40)
                }
                
                // Text field for list description with placeholder
                TextField("Enter list description...", text: Binding (
                    get: { lst?.desc ?? "" },
                    set: { lst?.desc = $0 }
                )) // Placeholder text disappears when typing
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                    .frame(width: 300)
                    .padding(.horizontal, 40)
                TextField("Enter list notes...", text: Binding (
                    get: { lst?.notes ?? "" },
                    set: { lst?.notes = $0 }
                )) // Placeholder text disappears when typing
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                    .frame(width: 300)
                    .padding(.horizontal, 40)
                
                VStack(spacing: 10) {
                    //for loop to print out the list of items as buttons with the name of the item as the text
                    ForEach(Array(lst?.items as? Set<ToDoItemEntity> ?? []), id: \.self) { item in
                        Button(action: {
                            page = .toDo
                        }) {
                            Text(item.name ?? "")
                        }
                    }
                
                    Button(action: {
                        history.push(.createList)
                        page = .toDo
                    }) {
                        Text("Add a new item")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                }
                Button(action: {
                    if let list = lst, let name = list.name?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty, name != "New List" {
                        // Only save if the name is valid and not the default "New List"
                        let safePriority = list.priority < 0 ? Int16(dbManager.getNumberOfLists() + 1) : list.priority
                        dbManager.updateList(list, name: name, 
                        description: list.desc ?? "", notes: list.notes ?? "",
                        priority: safePriority)
                        page = history.pop() ?? .lists
                        lst = nil
                    }
                }) {
                    Text("Create List")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                .disabled(!validName)
                
                Spacer() // Pushes content to top
            }
        }
        .onAppear {
            print(history.history)
            if lst == nil {
                let priority = Int16(dbManager.getNumberOfLists() + 1)
                // Create with a temporary name that gets updated
                dbManager.createList(name: "", description: "", notes: "", priority: priority)
                lst = dbManager.getListByName("")
            }
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
    return ListCreationView(page: .constant(.createList), lst: $testList)
        .environmentObject(DBManager())
        .environmentObject(HistoryStack())
}
