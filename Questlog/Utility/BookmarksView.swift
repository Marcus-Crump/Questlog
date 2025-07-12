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
                Button(action: {
                    page = "Lists" // Set page to "Lists" when pressed
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(.green) // Green color for Lists
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    page = "Projects" // Set page to "Projects" when pressed
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(.red) // Red color for Projects
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(Color.clear)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    page = "Loading" // Set page to "Loading" when pressed
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title)  // Make icon bigger
                        .fontWeight(.bold)  // Make icon thicker
                        .foregroundColor(.purple) // Purple color for Loading
                        .frame(width: 50, height: 50)  // Fixed size
                        .background(Color.clear)
                        .cornerRadius(10)
                }
            }
            .padding(.trailing, 20)  // Space from right edge
            .background(Color.clear)
        }
        .background(Color.clear)
        // No NavigationStack or navigationDestination used
    }
}

#Preview {
    @Previewable @State var p: String = "TOC"
    BookmarksView(page:$p)
}
