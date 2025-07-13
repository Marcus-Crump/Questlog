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
    @ObservedObject var ListState: ListFormState
    @State private var listName = ""
    @State private var listDescription = ""
    @State private var listNotes = ""
    @State private var listPriority = 0

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        VStack(spacing: 10) {
            HStack{
                Button(action: {
                    page = "Lists"
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundStyle(Color.black)
                }
            Text("Create a new list")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            }
            // Text field for list name with placeholder
            TextField("Enter list name...", text: $listName) // Placeholder text disappears when typing
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                .frame(width: 300)
                .padding(.horizontal, 40)
            
            // Text field for list description with placeholder
            TextField("Enter list description...", text: $listDescription) // Placeholder text disappears when typing
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                .frame(width: 300)
                .padding(.horizontal, 40)
            TextField("Enter list notes...", text: $listNotes) // Placeholder text disappears when typing
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Gives it a nice border
                .frame(width: 300)
                .padding(.horizontal, 40)
            
            VStack(spacing: 10) {
                //for loop to print out the list of items as buttons with the name of the item as the text
            
                Button(action: {
                    page = "ToDo"
                }) {
                    Text("Add a new item")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
            Button(action: {
                dbManager.createList(name: listName, 
                description: listDescription, notes: listNotes, 
                priority: listPriority)
                
                page = "Lists"
            }) {
                Text("Create List")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            
            Spacer() // Pushes content to top
        }
        }
    }
}


#Preview {
    @Previewable @State var p: String = "CreateList"
    ListCreationView(page: $p, listFormState: ListFormState(), dbManager: DBManager())
}
