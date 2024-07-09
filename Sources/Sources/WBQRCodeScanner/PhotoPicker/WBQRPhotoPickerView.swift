//
//  File.swift
//  
//
//  Created by WBear on 2024/7/4.
//

import Foundation
import SwiftUI

struct WBQRPhotoPickerView: View {
    
    @State var photoPicker = false
    
    var body: some View {
        Button {
            photoPicker.toggle()
        } label: {
            Image(systemName: "photo")
                .resizable()
                .frame(width: 30, height: 25)
                .foregroundColor(.white)
        }
        .sheet(isPresented: $photoPicker, content: {
            WBQRPhotoPicker()
                .ignoresSafeArea(edges: .bottom)
        })
    }
}
