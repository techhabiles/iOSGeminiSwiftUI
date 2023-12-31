//
//  CommonComponents.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

/**
 * Common components to be used across app
 */
import SwiftUI
import AVFAudio

struct THButton: View {
    @State var title: String
    @Binding var passedTitle : String
    @State var imageName: String
    @State var callBack: () -> Void = {}
    
    init(title: String = "", passedTitle: Binding<String> = .constant(""), imageName: String = "", callBack: @escaping () -> Void = {}) {
        self.title = title
        self.imageName = imageName
        self.callBack = callBack
        _passedTitle = passedTitle
    }
    
    var body: some View {
        Button(passedTitle.isEmpty ? title : passedTitle,
               systemImage: imageName,
               action: {
            callBack()
        }
        )
        .font(.headline)
        .frame(width: 150, height: 40)
        .background(CustomColor.THCOLOR)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct OutputView: View{
    @EnvironmentObject var viewModel : GeminiViewModel
    var body: some View{
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
}

struct TopView: View {
    @State var speaking = false
    @EnvironmentObject var viewModel : GeminiViewModel
    var body: some View {
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


