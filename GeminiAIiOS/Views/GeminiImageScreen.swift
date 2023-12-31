//
//  GeminiImageScreen.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

import SwiftUI
import UIKit
import GoogleGenerativeAI
import PhotosUI

// Gemini Screen for Image Read Text & Describe

struct GeminiImageButtonView: View{
    @Binding var selectedImage: UIImage?
    @State var item : PhotosPickerItem?
    @State var showCamera: Bool = false
    @State var showGallery: Bool = false
    @EnvironmentObject var viewModel: GeminiViewModel
    var body: some View{
        HStack{
            THButton(title: "Camera", imageName: "camera", callBack: {
                self.showCamera = true
            })
            .fullScreenCover(isPresented: self.$showCamera) {
                CameraImageview(selectedImage: self.$selectedImage)
            }
            Spacer()
             THButton(title: "Gallery", imageName: "grid", callBack: {
                 self.showGallery = true
             }).photosPicker(isPresented: $showGallery, selection: $item, matching: .images)
                .onChange(of: item) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImage = UIImage(data: data)
                                    viewModel.setImageSelected(selected: true)
                                }
                            }
                    
                }
        }
    }
}

struct SelectedImageView : View {
    
    @State var selection: String = "Describe"
    @Binding var selectedImage: UIImage?
    @EnvironmentObject var viewModel : GeminiViewModel
    
    var body: some View
    {
        VStack{
            RadioGroup(options: ["Describe", "Read Text"], selection: $selection)
            HStack{
                if(viewModel.isImageSelected) {
                    if let image = selectedImage  {
                        Image(uiImage: image)
                            .resizable()
                            .padding(10)
                            .frame(width: 200, height: 200)
                    }
                }
                VStack(spacing: 40){
                    THButton(passedTitle: $selection, callBack: {
                        let prompt = selection == "Describe" ? " Describe this image" : "Read text from this image"
                        guard let img = self.selectedImage else {
                            return
                        }
                        Task{
                            await viewModel.describeImage(text: prompt, image: img.jpeg(.low))
                            
                        }
                    })
                    
                    THButton(title: "Clear", callBack: {
                        viewModel.setImageSelected(selected: false)
                    })
                }
            }
        }
    }
}


struct GeminiImage: View {
    @StateObject var viewModel: GeminiViewModel = GeminiViewModel(type: .PRO_VISION)
    @State var selectedImage: UIImage?
    var body: some View {
        VStack{
            TopView()
            OutputView()
            if(viewModel.isImageSelected) {
                SelectedImageView( selectedImage: self.$selectedImage)
            }
            GeminiImageButtonView(selectedImage: self.$selectedImage)
        }.padding(10)
            .navigationTitle("Gemini Image")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModel)
    }
}

