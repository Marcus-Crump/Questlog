//
//  ListsView.swift
//  Questlog
//
//  Created by Marcus Crump on 7/9/25.
//

import Foundation
import SwiftUI

struct ListsView: View {
    @Binding var page: Page
    @State var newList: Bool = false
    @EnvironmentObject var dbManager: DBManager
    @EnvironmentObject var historyStack: HistoryStack
    @Binding var lst: ListEntity?
    
    var body: some View {
            ZStack {
                Background()
                BookmarksView(page:$page)  // NEW: Add bookmarks overlay
                
                // Main content overlay
                VStack {
               
                    HStack{
                        Text("Lists View")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                        Button(action: {
                            historyStack.push(.lists)
                            page = .createList
                        }) {
                            Image("WriteNewThing")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40) // Set specific size for the button
                        }
                    }
                    // Navigation links for your lists from Core Data
                    VStack(spacing: 10) {
                        ForEach(dbManager.getAllLists(), id: \.self) { list in
                            if let l = list.name {
                                Button(action: {
                                    historyStack.push(.lists)
                                    lst = dbManager.getListByName(l)
                                    page = .listDetail
                                }) {
                                    Text(l)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.clear)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer() // Balances the top spacer
                }
            .background(Color.clear)
            
            
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
    return ListsView(page: .constant(.lists), lst: $testList)
        .environmentObject(HistoryStack())
        .environmentObject(DBManager())
}
