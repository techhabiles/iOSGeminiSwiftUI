//
//  Screen.swift
//  GeminiAIiOS - Screen
//
//  Created by @TechHabiles on 27/12/23.
//

import SwiftUI
import AVFAudio

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

// Gemini Screen for AI Text

struct GeminiText: View {
    
    @FocusState var isFocused : Bool
    @State var speaking = false
    @EnvironmentObject var viewModel : GeminiViewModel
    
    var body: some View {
        VStack{
            topView
            outputView
            textEntryViewRow
            
        }.padding(10)
            .navigationTitle("Gemini Text")
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    var topView: some View {
        HStack{
            Text("Gemini Output")
                .font(.title)
                .foregroundColor(viewModel.response.isEmpty ? .gray : .black)
            Spacer()
            Button(action: {
                if(viewModel.response.isEmpty) {
                    return
                }
                if(!speaking){
                    speak(text: viewModel.response)
                }else{
                    stopSpeaking()
                }
                speaking.toggle()
                
            }, label: {
                Image(systemName: speaking ? "speaker.wave.3" : "speaker.wave.3", variableValue: speaking ? 1 : 0.0)
                    .resizable()
                    .font(.title)
            }).frame(width: 60, height: 40)
            
        }
    }
    var outputView : some View{
        ZStack{
            Color.white
            ScrollView{
                Text(viewModel.response)
            }
            if(viewModel.inProgress){
                ProgressView()
            }
        }
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
    
    private let synthesizer = AVSpeechSynthesizer()
    
    private func speak(text: String){
        let speech = AVSpeechUtterance(string: text)
        speech.voice = AVSpeechSynthesisVoice(language: Locale.preferredLanguages.first)
        synthesizer.speak(speech)
        
    }
    
    private func stopSpeaking(){
        synthesizer.stopSpeaking(at: .immediate)
    }
}

// Gemini Screen for Image Read & Describe

struct GeminiImage: View {
    var body: some View {
        VStack{
            Text("Coming Soon").font(.title)
        }.navigationTitle("Gemini Image")
            .navigationBarTitleDisplayMode(.inline)
    }
}


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



// Custome Color, More Colors can be added to this
struct CustomColor {
    static let THCOLOR: Color = Color(UIColor(hexString: "#265AC7"))
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

struct ContentView_Preview: PreviewProvider{
    static var previews: some View{
        return MainView()
    }
}

