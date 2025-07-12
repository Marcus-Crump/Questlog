//
//  ProjectsView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ProjectsView: View {
    @Binding var page: String
    var body: some View {
        ZStack {
            Color.green
            Text("Projects")
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    @Previewable @State var p: String = "Projects"
    ProjectsView(page:$p)
}
