//
//  Untitled.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct ProjectDetailView: View {
    @Binding var page: Page
    @EnvironmentObject var history: HistoryStack
    var body: some View {
        ZStack {
            Color.yellow
            Text("Project Detail")
            BookmarksView(page:$page)
        }
        .onAppear {
            print(history.history)
        }
    }
}

#Preview {
    return ProjectDetailView(page: .constant(.projects))
        .environmentObject(HistoryStack())
}
