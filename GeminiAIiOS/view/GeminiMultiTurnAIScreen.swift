//
//  GeminiMultiTurnAIScreen.swift
//  GeminiAIiOS
//
//  Created by @TechGabiles on 31/12/23.
//

import SwiftUI

// Gemini Screen for Multiturn conversation

struct GeminiMultiTurn: View {
    @EnvironmentObject var viewModel: GeminiViewModel
    var body: some View {
        VStack{
            Text("Coming Soon").font(.title)
        }.navigationTitle("Gemini Multi Turn")
            .navigationBarTitleDisplayMode(.inline)
    }
}

