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
            Color.black
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Text("Table of Contents")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 40)
                
                Spacer()
                
                VStack {
                    Button(action: {
                        page = "Lists"
                    }) {
                        Text("Lists")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        page = "Projects"
                    }) {
                        Text("Projects")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Button(action: {
                        page = "ToDo"
                    }) {
                        Text("ToDo")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                Spacer()
            }
        }
    }
}

#Preview {
    return TOCView(page: .constant("TOC"))
}
