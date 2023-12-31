//
//  Screen.swift
//  GeminiAIiOS - Screen
//
//  Created by @TechHabiles on 27/12/23.
//

import SwiftUI


/**
 *  Main Screen Which comes after splash Screen
 */
struct MainView : View {
    
    @State var text = ""
    
    var body: some View {
        
        VStack (spacing: 20){
            Image("techhabiles")
                .resizable()
                .frame(width:300, height: 300)
                .cornerRadius(150)
                .background(
                    Circle()
                        .fill(Color.gray)
                        .frame(width:320, height: 320)
                )
            NavigationLink {
                // Navigates to Gemni Text
                GeminiText()
            } label: {
                Text("Gemini Text AI").foregroundStyle(.background )
                    .frame(width: 300, height: 40)
                    .background(CustomColor.THCOLOR)
                    .cornerRadius(10)
                    .font(.headline)
            }
            
            NavigationLink {
                // Navigates to Screen for image input for Gemini model
                GeminiImage()
            } label: {
                Text("Gemini Image Describe & Read").foregroundStyle(.background )
                    .frame(width: 300, height: 40)
                    .background(CustomColor.THCOLOR)
                    .cornerRadius(10)
                    .font(.headline)
            }
            NavigationLink {
                // Navigates to Screen for multiturn conversation
                GeminiMultiTurn()
            } label: {
                Text("Gemini Multi Turn Converstaion").foregroundStyle(.background )
                    .frame(width: 300, height: 40)
                    .background(CustomColor.THCOLOR)
                    .cornerRadius(10)
                    .font(.headline)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Preview: PreviewProvider{
    static var previews: some View{
        return MainView()
    }
}

