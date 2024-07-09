//
//  WBQRPhotoPicker.swift
//  
//
//  Created by WBear on 2024/4/8.
//

import PhotosUI
import SwiftUI

struct WBQRPhotoPicker: UIViewControllerRepresentable {
    
    @EnvironmentObject var result: WBQRPhotoPickerResult
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: WBQRPhotoPicker

        init(_ parent: WBQRPhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.result.selectImage = image as? UIImage
                    }
                }
            }
        }
    }
}
