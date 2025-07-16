//
//  ListsView.swift
//  Questlog
//
//  Created by Marcus Crump on 7/9/25.
//

import Foundation
import SwiftUI

struct ListsView: View {
    @Binding var page: String
    @State var newList: Bool = false
    @ObservedObject var dbManager: DBManager
    private var list: ListEntity?
    
    var body: some View {
            ZStack {
                // Background image that fills the entire screen
            Image("Stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fit)
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
                            page = "CreateList"
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
                            if let n = list.name {
                                Button(action: {
                                    list = dbManager.getListByName(n)
                                    page = "ListDetail"
                                }) {
                                    Text(n)
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
    }
}

 #Preview {
    ListsView(page: .constant("Lists"), dbManager: DBManager())
 }
