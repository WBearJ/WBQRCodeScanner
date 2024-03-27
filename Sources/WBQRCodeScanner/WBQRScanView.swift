//
//  WBQRScanView.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import Foundation
import SwiftUI

@available(iOS 15, *)
struct WBQRScanView: UIViewRepresentable {
    
    // scan result
    var scanResults: WBQRCameraView.ScanResults
    
    // error message
    @Binding var errorMessage: String?
    
    typealias UIViewType = WBQRCameraView
    
    func makeUIView(context: Context) -> WBQRCameraView {
        let cameraView = WBQRCameraView(scanResluts: scanResults) { message in
            DispatchQueue.main.async {
                errorMessage = message
            }
        }

        return cameraView
    }
    
    func updateUIView(_ uiView: WBQRCameraView, context: Context) {
    }
}

