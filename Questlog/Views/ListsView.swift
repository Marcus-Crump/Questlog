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
    var body: some View {
            ZStack {
                // Background image that fills the entire screen
            Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                // Main content overlay
                VStack {
               
                    
                    Text("Lists View")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    
                // Spacer() // Pushes content to center
                    // Navigation links for your lists
                    VStack(spacing: 10) {
                    Button(action: {
                        page = "Todo1"
                    }) {
                            Text("List 1")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                            .background(Color.clear)
                        }
                        
                    Button(action: {
                        page = "Todo2"
                    }) {
                            Text("List 2")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                            .background(Color.clear)
                        }
                        
                    Button(action: {
                        page = "Todo3"
                    }) {
                            Text("List 3")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                            .background(Color.clear)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer() // Balances the top spacer
                }
            .background(Color.clear)
            
            BookmarksView(page:$page)  // NEW: Add bookmarks overlay
        }
    }
}

#Preview {
    @Previewable @State var p: String = "Lists"
    ListsView(page:$p)
}
