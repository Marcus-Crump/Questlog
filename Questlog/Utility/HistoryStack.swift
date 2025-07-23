//
//  HistoryStack.swift
//  Questlog
//
//  Created by Kaitlyn Martin on 7/21/25.
//

import Foundation
import SwiftUI

enum Page: String {
    case lists
    case createList
    case listDetail
    case toDo
    case toDoDetail
    case projects
    case projectDetail
    case createProject
    case daily
    case calendar
    case settings
    case toc
}

class HistoryStack: ObservableObject {
    @Published var history: [Page] = []

    func push(_ page: Page) {
        history.append(page)
    }
    func pop() -> Page? {
        return history.popLast()
    }
    func clear() {
        history.removeAll()
    }

    var top: Page? {
        history.last
    }
}
