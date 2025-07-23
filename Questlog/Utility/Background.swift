//
//  Background.swift
//  Questlog
//
//  Created by Kaitlyn Martin on 7/21/25.
//

import SwiftUI

struct Background: View {
    
    var body: some View {
        ZStack {
            Image("Stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

