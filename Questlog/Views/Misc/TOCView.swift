//
//  TOCView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct TOCView: View {
    @Binding var page: Page
    @EnvironmentObject var history: HistoryStack
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                Text("Table of Contents")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 40)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Button(action: {
                        page = .lists
                    }) {
                        Text("Lists")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                    }
                    Button(action: {
                        page = .projects
                    }) {
                        Text("Projects")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        page = .daily
                    }) {
                        Text("Daily Tasks")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        page = .calendar
                    }) {
                        Text("Calendar")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        page = .settings
                    }) {
                        Text("Settings")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
                Spacer()
            }
        }
        .onAppear {
            print(history.history)
        }
        
    }
}

#Preview {
    return TOCView(page: .constant(.toc))
        .environmentObject(HistoryStack())
}
