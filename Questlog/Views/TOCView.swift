//
//  TOCView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct TOCView: View {
    @Binding var page: String

    var body: some View {
        ZStack {
            Image("Stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
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
                        page = "Lists"
                    }) {
                        Text("Lists")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                    }
                    Button(action: {
                        page = "Projects"
                    }) {
                        Text("Projects")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        page = ""
                    }) {
                        Text("Daily Tasks")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        page = ""
                    }) {
                        Text("Calendar")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Button(action: {
                        page = ""
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
    }
}

#Preview {
    return TOCView(page: .constant("TOC"))
}
