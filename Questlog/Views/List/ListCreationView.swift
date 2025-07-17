//
//  ListCreationView.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//

import SwiftUI
import Foundation

struct ListCreationView: View {
    @Binding var page: String
    @ObservedObject var dbManager: DBManager
    @Binding var lst: ListEntity?

    private var validName: Bool {
        
        if let l = lst {
            let strip: String = l.name?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            return strip.count > 0 && dbManager.getListByName(strip) == nil
        }
        return false
    }

    var duplicateListExists: Bool {
        let request = ListEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", lst?.name ?? "")
        if let results = try? dbManager.container.viewContext.fetch(request) as [ListEntity] {
            return results.contains(where: { $0 != lst })
        }
        return false
    }

    var body: some View {
        ZStack {
            Image("Stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fit)
        VStack(spacing: 10) {
            HStack{
                Spacer()
                Button(action: {
                    if let l = lst {
                        dbManager.deleteList(l)
                        lst = nil
                    }
                    page = "Lists"
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
                        page = "ToDo"
                    }) {
                        Text(item.name ?? "")
                    }
                }
            
                Button(action: {
                    page = "ToDo"
                }) {
                    Text("Add a new item")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
            Button(action: {
                page = "Lists"
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
            if lst == nil {
            let priority = Int16(dbManager.getNumberOfLists() + 1)

            dbManager.createList(name: "", description: "New Description", notes: "New Notes", priority: priority)

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
    return ListCreationView(page: .constant("CreateList"), 
                            dbManager: DBManager(),lst: $testList)
}
