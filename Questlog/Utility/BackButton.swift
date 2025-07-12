////
////  BackButton.swift
////  Questlog
////
////  Created by Mars on 7/11/25.
////
//
//import SwiftUI
//
//struct BackButton: View {
//    @Binding var navigationHistory: [String]
//    var body: some View {
//        Button(action: {
//            var previousView = navigationHistory.removeLast()
//            switch previousView {
//                case "lists":
//                    showToDoView = true
//                case "projects":
//                    showProjectDetailView = true
//            }
//        }) {
//            Image(systemName: "chevron.left")
//        }
//    }
//}
//
//#Preview {
//    BackButton(navigationHistory: .constant([]))
//}
