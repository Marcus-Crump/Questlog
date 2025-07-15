//
//  Untitled.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ProjectDetailView: View {
    @Binding var page: String
    var body: some View {
        ZStack {
            Color.yellow
            Text("Project Detail")
            BookmarksView(page:$page)
        }
    }
}

#Preview {
    return ProjectDetailView(page: .constant("ProjectDetail"))
}
