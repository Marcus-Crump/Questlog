//
//  QuestlogApp.swift
//  Questlog
//
//  Created by Mars on 7/10/25.
//

import SwiftUI

@main
struct QuestlogApp: App {
    @StateObject private var dbManager = DBManager()  // Initialize Core Data stack
    @StateObject private var historyStack = HistoryStack()  // Initialize history stack
    @State private var isLoading = true  // Track loading state
    
    var body: some Scene {
        WindowGroup {
            ZStack {  // Stack loading and main content
                if isLoading {
                    LoadingView()  // Show loading screen
                        .transition(.opacity)  // Fade transition
                } else {
                    ContentView()  // Show main content
                        .environmentObject(dbManager)  // Pass Core Data manager to views
                        .environmentObject(historyStack)  // Pass history stack to views
                        .transition(.opacity)  // Fade transition
                }
            }
            .animation(.easeInOut(duration: 0.5), value: isLoading)  // Smooth animation
            .onAppear {
                // Simulate loading time - replace with actual initialization
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isLoading = false  // Switch to main content
                    }
                }
            }
        }
    }
}
