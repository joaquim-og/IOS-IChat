//
//  ImagePickerView.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 15/03/24.
//

import Foundation
import UIKit
import SwiftUI

import Foundation
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
  
  @Environment(\.presentationMode) private var presentationMode
  @Binding var selectedImage: UIImage
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
    
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = context.coordinator
    
    return imagePicker
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
    
  }
  
  final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePickerView
    
    init(_ parent: ImagePickerView) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        parent.selectedImage = image
      }
      
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
}


struct ImagePickerView_Previews: PreviewProvider {
    @State static var selectedImage = UIImage()
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ImagePickerView(
                selectedImage: $selectedImage
            )
            .frame(maxWidth: .infinity, maxHeight: 350)
            .preferredColorScheme($0)
        }
    }
}
