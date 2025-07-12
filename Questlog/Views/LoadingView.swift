//
//  LoadingView.swift
//  Questlog
//
//  Created by Mars on 7/11/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Image("LoadingScreen")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)  // Use all available space
//                .ignoresSafeArea()  // Extend to screen edges
//            
            VStack {
                Spacer()  // Push content to bottom
                
                VStack(spacing: 20) {  // Group wheel and text with spacing
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .scaleEffect(1.5)  // Make wheel larger
                    
                    Text("Summoning the Monke...")
                        .foregroundColor(Color.white)
                        .font(.headline)  // Larger text
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)  // Align to bottom
                .padding(.bottom, 100)  // Distance from bottom edge
            }
        }
    }
}

#Preview {
    LoadingView()
}

