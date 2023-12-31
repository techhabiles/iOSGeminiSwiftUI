//
//  GeminiMultiTurnAIScreen.swift
//  GeminiAIiOS
//
//  Created by @TechGabiles on 31/12/23.
//

import SwiftUI

// Gemini Screen for Multiturn conversation

struct GeminiMultiTurn: View {
    @StateObject var viewModel = GeminiViewModel()
    
    var body: some View {
        VStack{
            TopView()
            OutputView()
            TextEntryView(callBack: {
                Task{
                    await viewModel.sendMessage()
                }
            })
            
        }.padding(10)
            .navigationTitle("Gemini Multi-turn")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModel)
            .onAppear(){
                viewModel.initChat()
            }
    }
}

