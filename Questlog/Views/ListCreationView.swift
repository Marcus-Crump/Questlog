//
//  ListCreationView.swift
//  Questlog
//
//  Created by Mars on 7/13/25.
//

import SwiftUI

struct ListCreationView: View {
    @Binding var page: String
    @ObservedObject var dbManager: DBManager
    private var list: ListEntity?

    private var validName: Bool {
        return !listName.trimmingCharacters(in: .whitespaces).isEmpty
            && dbManager.getListByName(listName) == nil
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
                    if let l = list {
                        dbManager.deleteList(l)
                        list = nil
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
            // Text field for list name with placeholder
            let request = ListEntity.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", list?.name ?? "")
            if let results = try? dbManager.container.viewContext.fetch(request) as? [ListEntity],
               results.contains(where: { $0 != list }) {
                Text("List name already exists")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            TextField("Enter list name...", text: Binding (
                get: { list?.name ?? "" },
                set: { list?.name = $0 }
            )) // Placeholder text disappears when typing
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                .frame(width: 300)
                .padding(.horizontal, 40)
            }
            
            // Text field for list description with placeholder
            TextField("Enter list description...", text: Binding (
                get: { list?.desc ?? "" },
                set: { list?.desc = $0 }
            )) // Placeholder text disappears when typing
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                .frame(width: 300)
                .padding(.horizontal, 40)
            TextField("Enter list notes...", text: Binding (
                get: { list?.notes ?? "" },
                set: { list?.notes = $0 }
            )) // Placeholder text disappears when typing
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                .frame(width: 300)
                .padding(.horizontal, 40)
            
            VStack(spacing: 10) {
                //for loop to print out the list of items as buttons with the name of the item as the text
                ForEach(list?.items ?? [], id: \.self) { item in
                    Button(action: {
                        page = "ToDo"
                    }) {
                        Text(item.name)
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
            if list == nil {
            let priority = Int16(dbManager.getNumberOfLists() + 1)

            dbManager.createList(name: "", description: "New Description", notes: "New Notes", priority: priority)

                list = dbManager.getListByName("")
            }
        }
    }
}


#Preview {
    let testList = ListEntity(context: PersistenceController.preview.container.viewContext)
    testList.name = "Test List"
    testList.desc = "Test Description"
    testList.notes = "Test Notes"
    return ListCreationView(page: .constant("CreateList"), dbManager: DBManager(), list: testList)
}
