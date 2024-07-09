//
//  WBQRScanView.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import Foundation
import SwiftUI

@available(iOS 13, *)
struct WBQRCameraScanView: UIViewRepresentable {
    
    @Environment(\.dismissable) private var dismiss
    
    /// scan result
    var scanResults: WBQRCameraView.ScanResults
    
    /// error message
    @Binding var errorMessage: String?
    
    
    typealias UIViewType = WBQRCameraView
    
    func makeUIView(context: Context) -> WBQRCameraView {
        let cameraView = WBQRCameraView(scanResluts: scanResults) { message in
            DispatchQueue.main.async {
                errorMessage = message
            }
        }
        cameraView.dismiss = {
            dismiss()
        }
        return cameraView
    }
    
    func updateUIView(_ uiView: WBQRCameraView, context: Context) {}
    
    static func dismantleUIView(_ uiView: WBQRCameraView, coordinator: ()) {
        if uiView.isRunning {
            uiView.stopRunning()
        }
    }
}

