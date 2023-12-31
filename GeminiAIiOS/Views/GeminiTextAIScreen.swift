//
//  GeminiTextAIScreen.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

import SwiftUI

// Gemini Screen for AI Text

struct GeminiText: View {
    
    @FocusState var isFocused : Bool
    @State var speaking = false
    @StateObject var viewModel : GeminiViewModel = GeminiViewModel()
    
    var body: some View {
        VStack{
            TopView()
            OutputView()
            textEntryViewRow
            
        }.padding(10)
            .navigationTitle("Gemini Text")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModel)
        
    }
    
    var textEntryViewRow : some View {
        HStack{
            TextField("Enter text", text: $viewModel.prompt, axis: .vertical)
                .focused($isFocused)
                .frame(height: 40)
                .padding(.leading, 5)
                .padding(.trailing,10)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                isFocused = false
                Task{
                    await viewModel.generateContent()
                }
            }, label: {
                Text("Go")
                    .frame(width: 40, height: 40)
                    .font(.headline)
                    .background(viewModel.prompt.isEmpty ? Color.gray : CustomColor.THCOLOR)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                
            }).disabled(viewModel.prompt.isEmpty)
        }
    }
}
