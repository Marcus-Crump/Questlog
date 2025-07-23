//
//  BookmarksView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct BookmarksView: View {
    @Binding var page: Page
    
    var body: some View {
        HStack { // Horizontal stack for layout
            Spacer()  // Push buttons to right side
            
            VStack(spacing: 20) {  // Add spacing between buttons
                Spacer()
                Button(action: {
                    page = .lists // Set page to "Lists" when pressed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(page == .lists ? .black : .white) // White color for better visibility
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(page == .lists ? Color.gray.opacity(0.7) : Color.black.opacity(0.7)) // Semi-transparent background
                        .cornerRadius(10)
                }
                .disabled(page == .lists)
                
                Button(action: {
                    page = .projects // Set page to "Projects" when pressed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(page == .projects ? .black : .white) // White color for better visibility
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(page == .projects ? Color.gray.opacity(0.7) : Color.black.opacity(0.7)) // Semi-transparent background
                        .cornerRadius(10)
                }
                .disabled(page == .projects)
                Button(action: {
                    page = .toc // Set page to "Loading" when pressed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(page == .toc ? .black : .white) // White color for better visibility
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(page == .toc ? Color.gray.opacity(0.7) : Color.black.opacity(0.7)) // Semi-transparent background
                        .cornerRadius(10)
                }
                .disabled(page == .toc)
                
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
    BookmarksView(page: .constant(.toc))
}
