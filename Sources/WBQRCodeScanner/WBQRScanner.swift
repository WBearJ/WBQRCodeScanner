//
//  WBQRScanner.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import SwiftUI

@available(iOS 15, *)
public struct WBQRScanner<Preview: View>: View {
    
    let preview: () -> Preview
    
    // error message
    @State var errorMessage: String?
    
    var scanResults: WBQRCameraView.ScanResults
    
    public init(@ViewBuilder preview: @escaping () -> Preview, scanResults: @escaping WBQRCameraView.ScanResults) {
        self.preview = preview
        self.scanResults = scanResults
    }
    
    public var body: some View {
        ZStack {
            if let errorMessage {
                WBQRScanErrorView(errorMessage: errorMessage)
            }else {
                WBQRScanView(scanResults: scanResults, errorMessage: $errorMessage)
                    .ignoresSafeArea(.all)
                preview()                
            }
        }
        .navigationBarBackButtonHidden()
    }
}
