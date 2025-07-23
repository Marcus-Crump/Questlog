//
//  ProjectsView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ProjectsView: View {
    @Binding var page: Page
    @EnvironmentObject var history: HistoryStack
    var body: some View {
        ZStack {
            Color.green
            Text("Projects")
            BookmarksView(page:$page)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            print(history.history)
        }
    }
}

#Preview {
    return ProjectsView(page: .constant(.projects))
        .environmentObject(HistoryStack())
}
