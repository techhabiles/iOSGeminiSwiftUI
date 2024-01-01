//
//  TextEntryView.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

import SwiftUI

struct TextEntryView: View {
    @EnvironmentObject var viewModel: GeminiViewModel
    @FocusState var isFocused : Bool
    @State var callBack: () -> Void 
    
    var body: some View {
        HStack{
            TextField("Enter Text", text: $viewModel.prompt, axis: .vertical)
                .focused($isFocused)
                .frame(height: 40)
                .padding(.leading, 5)
                .padding(.trailing,10)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                isFocused = false
                callBack()
                
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

