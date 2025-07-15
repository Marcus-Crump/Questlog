//
//  BookmarksView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct BookmarksView: View {
    @Binding var page: String
    
    var body: some View {
        HStack { // Horizontal stack for layout
            Spacer()  // Push buttons to right side
            
            VStack(spacing: 20) {  // Add spacing between buttons
                Spacer()
                Button(action: {
                    page = "Lists" // Set page to "Lists" when pressed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(page == "Lists" ? .black : .white) // White color for better visibility
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(page == "Lists" ? Color.gray.opacity(0.7) : Color.black.opacity(0.7)) // Semi-transparent background
                        .cornerRadius(10)
                }
                .disabled(page == "Lists")
                
                Button(action: {
                    page = "Projects" // Set page to "Projects" when pressed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(page == "Projects" ? .black : .white) // White color for better visibility
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(page == "Projects" ? Color.gray.opacity(0.7) : Color.black.opacity(0.7)) // Semi-transparent background
                        .cornerRadius(10)
                }
                .disabled(page == "Projects")
                Button(action: {
                    page = "Loading" // Set page to "Loading" when pressed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(page == "Loading" ? .black : .white) // White color for better visibility
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(page == "Loading" ? Color.gray.opacity(0.7) : Color.black.opacity(0.7)) // Semi-transparent background
                        .cornerRadius(10)
                }
                .disabled(page == "Loading")
                
                Spacer() // Balance the VStack to center it vertically
            }
            .padding(.trailing, 50)  // More space from right edge to keep on screen
            .background(Color.clear)
        }
        .background(Color.clear)
        .zIndex(1) // Ensure bookmarks appear on top
        // No NavigationStack or navigationDestination used
    
    }
}

#Preview {
    BookmarksView(page: .constant("TOC"))
}
