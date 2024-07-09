//
//  ContentView.swift
//  WBQRCodeScannerDemo
//
//  Created by WBear on 2024/3/27.
//

import SwiftUI
import WBQRCodeScanner

struct ContentView: View {
    
    @State var results = [WBQRBarcodeResult]()
    
    
    @State var scanToggle = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                contentView()
            }
        } else {
            VStack {
                contentView()
            }
            .fullScreenCover(isPresented: $scanToggle) {
                WBQRScanner { results in
                    self.results = results
                }
            }
        }
    }
    
    func contentView() -> some View {
        VStack(spacing: 20) {
            // Default Preview
            defaultPreview()
            
            // Customize Preview
            customizePreview()
            
            // scan value
            if !results.isEmpty {
                // title
                Text("Scan Result")
                    .font(.title3)
                    .padding(.top, 10)
                // results
                ForEach(results, id: \.stringValue) { result in
                    Text("Result: \(result.stringValue ?? "")")
                }
            }
        }
    }
}

// MARK: - Default Preview
extension ContentView {
    func defaultPreview() -> some View {
        NavigationLink {
            WBQRScanner { results in
                self.results = results
            }
        } label: {
            Text("Default Scan Preview")
        }
    }
}

// MARK: - Customize Preview
extension ContentView {
    func customizePreview() -> some View {
        NavigationLink {
            WBQRScanner {
                CustomizePreview()
            } scanResults: { results in
                self.results = results
            }
        } label: {
            Text("Customize Scan Preview")
        }
    }
}

#Preview {
    ContentView()
}
