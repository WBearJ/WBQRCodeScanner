//
//  CustomizePreview.swift
//  WBQRCodeScannerDemo
//
//  Created by WBear on 2024/7/9.
//

import SwiftUI
import WBQRCodeScanner

struct CustomizePreview: View {
    
    @Environment(\.dismissable) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            // text
            Text("This is customize preview")
                .foregroundColor(.white)
            
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

#Preview {
    CustomizePreview()
}
