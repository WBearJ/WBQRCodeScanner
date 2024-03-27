//
//  WBQRScanErrorView.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/26.
//

import SwiftUI

@available(iOS 15, *)
struct WBQRScanErrorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var errorMessage: String
    
    var body: some View {
        ZStack {
            Text(errorMessage)
            
            VStack {
                HStack {
                    Button {
                         dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                
                Spacer()
            }
        }
    }
}
