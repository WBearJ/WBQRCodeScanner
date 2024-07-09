//
//  WBQRScanPreview.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import SwiftUI
import Foundation

@available(iOS 13, *)
public struct WBQRScanPreview: View {
    
    // init
    public init() {}
    
    /// dismiss
    @Environment(\.dismissable) private var dismiss
    
    /// animated line
    @State private var lineOffsetY: CGFloat?
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                // back button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                
                
                Image("scan_line", bundle: .module)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                    .offset(x: 0, y: lineOffsetY ?? (geometry.size.height * 0.2))
                    .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: lineOffsetY)
                    .onAppear {
                        lineOffsetY = geometry.size.height * 0.6
                    }
                
                Spacer()
                
                HStack {
                    WBQRPhotoPickerView()
                }
                .padding(.bottom, 20)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
