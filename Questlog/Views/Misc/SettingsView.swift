//
//  SettingsView.swift
//  Questlog
//
//  Created by Kaitlyn Martin on 7/19/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var page: Page
    @EnvironmentObject var dbManager: DBManager
    @EnvironmentObject var history: HistoryStack

    var body: some View {
        ZStack {
            Background()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        page = history.pop() ?? .toc
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(.top, 25)
                    }
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    dbManager.deleteAllData()
                }) {
                    Text("Clear All Data")
                        .font(.headline)
                        .foregroundColor(.black)
                }
                Spacer()
            }

        }
    }
}