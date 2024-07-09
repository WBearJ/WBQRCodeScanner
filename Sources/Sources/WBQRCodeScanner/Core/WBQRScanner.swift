//
//  WBQRScanner.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import SwiftUI

@available(iOS 13, *)
public struct WBQRScanner<Preview: View>: View {
    
    /// dismiss
    @Environment(\.dismissable) private var dismiss
    
    /// scan preview
    let preview: () -> Preview
    
    /// error message
    @State var errorMessage: String?
    
    /// photo album select
    @ObservedObject private var photoSelect = WBQRPhotoPickerResult()
    
    /// scan results
    private var scanResults: WBQRCameraView.ScanResults
    
    
    /// initializer with scan preview，
    /// - Parameters:
    ///   - preview: preview over camera view
    ///   - config: scan config
    ///   - scanResults: board code scan results
    public init(@ViewBuilder preview: @escaping () -> Preview = { WBQRScanPreview() }, config: WBQRScanConfig = WBQRScanConfig(), scanResults: @escaping WBQRCameraView.ScanResults) {
        self.preview = preview
        self.scanResults = scanResults
    }
    
    public var body: some View {
        ZStack {
            if let errorMessage {
                WBQRScanErrorView(errorMessage: errorMessage)
            }else {
                WBQRCameraScanView(scanResults: scanResults, errorMessage: $errorMessage)
                    .ignoresSafeArea(.all)
                preview()
                    .environmentObject(photoSelect)
            }
        }
        .navigationBarBackButtonHidden()
        .onChange(of: photoSelect.selectImage) { image in
            if let value = image?.detectQRCode() {
                scanResults([WBQRBarcodeResult(stringValue: value)])
                dismiss()
            }
        }
    }
}

// MARK: - Image QR Recognize
extension UIImage {
    func detectQRCode() -> String? {
        guard let ciImage = ciImage ?? CIImage(image: self) else {
            return nil
        }
        
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let context = CIContext()
        
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options) else {
            return nil
        }
        
        let features = detector.features(in: ciImage)
        
        if let feature = features.first as? CIQRCodeFeature {
            return feature.messageString
        }
        
        return nil
    }
}
