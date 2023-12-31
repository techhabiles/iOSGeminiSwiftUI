//
//  GeminiTextAIScreen.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

import SwiftUI

// Gemini Screen for AI Text

struct GeminiText: View {
    
    @State var speaking = false
    @StateObject var viewModel : GeminiViewModel = GeminiViewModel()
    
    var body: some View {
        VStack{
            TopView()
            OutputView()
            TextEntryView(callBack: {
                Task{
                    await viewModel.generateContent()
                }
            })
            
        }.padding(10)
            .navigationTitle("Gemini Text")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModel)
        
    }
    

}
