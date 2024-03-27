//
//  WBQRScanPreview.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import SwiftUI
import Foundation

@available(iOS 15, *)
public struct WBQRScanPreview: View {
    
    public init(results: Binding<[WBQRBarcodeResult]>) {
        self._results = results
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @State var lineOffsetY: CGFloat?
    
    @Binding var results: [WBQRBarcodeResult]
    
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
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onChange(of: results) { results in
                dismiss()
            }
        }
    }
}
