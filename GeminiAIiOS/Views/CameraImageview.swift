//
//  CameraImageview.swift
//  GeminiAIiOS
//
//  Created by @TechGabiles on 31/12/23.
//

import SwiftUI
import PhotosUI

/**
 * Camera Picker
 */

struct CameraImageview: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    
    @Environment(\.presentationMode) var isPresented
    
    @EnvironmentObject var viewModel: GeminiViewModel
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: CameraImageview
    
    init(picker: CameraImageview) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.viewModel.setImageSelected(selected: true)
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker.viewModel.setImageSelected(selected: false)
    }
}
