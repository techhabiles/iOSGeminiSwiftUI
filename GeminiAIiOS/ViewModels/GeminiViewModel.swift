//
//  GeminiViewModel.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 29/12/23.
//

import Foundation
import GoogleGenerativeAI
import UIKit

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
    @Published var isImageSelected = false
    
    var chat: Chat?
    
    /**
     * Describe Image or read text from Image
     */
    func describeImage(text: String, image: UIImage) async {
        self.setResponse( "")
        
        do {
            self.setProgress( true)
            let resp = try await  model.generateContent(text, image)
            if let responseText = resp.text {
                self.setResponse(responseText)
                self.setProgress(false)
            }else{
                self.setResponse("Error while fetching text")
                self.setProgress(false)
            }
            
        } catch  {
            self.setProgress(false)
            self.setResponse(error.localizedDescription)
            
        }
    }
    
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
        let pText = prompt
        setPrompt("")
        do {
            self.setProgress( true)
            let p = "Summarize the following text for me: \(pText)"
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
     * Init chat session
     */
    func initChat(){
        chat = model.startChat()
    }
    
    /**
     * Send next chat message
     */
    func sendMessage() async {
        setProgress(true)
        let pText = prompt
        setPrompt("")
        setResponse("\(response) Me: \(pText)\n")
        do{
            if let chatObj = chat {
                let reply = try await chatObj.sendMessage(pText)
                if let resp = reply.text {
                    setResponse("\(response) Gemini: \(resp)\n")
                }
                setProgress(false)
                setPrompt("")
            }
            
        }catch{
            print(" error is \(error.localizedDescription)")
            setProgress(false)
            setPrompt("")
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
    
    func setImageSelected(selected: Bool){
        self.isImageSelected = selected
        self.response = ""
    }
    
}
