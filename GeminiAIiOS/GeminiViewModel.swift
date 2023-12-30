//
//  GeminiViewModel.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 29/12/23.
//

import Foundation
import GoogleGenerativeAI

enum GEMINI_TYPE{
    case PRO
    case PRO_VISION
}
/**
 *  ViewModel class to geneate Gemini AI responses
 */

class GeminiViewModel : ObservableObject {
    
    var model: GenerativeModel
    /**
     *  Creates generative model based on if we want text based or text + images, default is text only
     */
    init(type: GEMINI_TYPE = GEMINI_TYPE.PRO){
        model = GenerativeModel(name: type == GEMINI_TYPE.PRO ? "gemini-pro" : "gemini-pro-vision",apiKey: Keys.API_KEY)
    }
    @Published var prompt: String = ""
    @Published var response: String = ""
    @Published var inProgress = false
    
    /**
     *  Generates response as text from Gemini AI LLM model and update views
     */
    
    func generateContent() async {
        self.setResponse( "")
        self.setProgress(false)
        if(prompt == ""){
            setResponse("Please enter query text")
            return
        }
        do {
            self.setProgress( true)
            let p = "Summarize the following text for me: \(prompt)"
            let outputContentStream = model.generateContentStream(p)
            self.setPrompt("")
            for try await outputContent in outputContentStream {
                   guard let line = outputContent.text else {
                     return
                }

                self.setResponse(response + line)
                 }
            self.setProgress(false)
            } catch  {
                self.setProgress(false)
                self.setResponse(error.localizedDescription)
                
            }
        

    }
    /**
     *  Setter function for  prompt on Main Thread
     */
    private func setPrompt(_ text: String){
        DispatchQueue.main.async {
            self.prompt = text
        }
    }
    /**
     *  Setter function for progress on Main Thread
     */
    private func setProgress(_ value: Bool){
        DispatchQueue.main.async {
            self.inProgress = value
        }
    }
    
    /**
     *  Setter function for response on Main Thread
     */
    private func setResponse(_ text: String){
        DispatchQueue.main.async {
            self.response = text
        }
    }
    
    func onCleanData(){
        setPrompt("")
        setProgress(false)
        setResponse("")
    }

}
