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
    
    @State var defaultLinkActive = false
    
    @State var customizeLinkActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                // defalut preview
                NavigationLink(
                    destination: defaultPreview(),
                    isActive: $defaultLinkActive,
                    label: {
                        Text("Default Scan Preview")
                    })
                
                // customize preview
                NavigationLink(
                    destination: customizePreview(),
                    isActive: $customizeLinkActive,
                    label: {
                        Text("Customized Scan Preview")
                    })
                .padding(.top, 20)
                
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
            .padding()
        }
    }
}

// MARK: - Default Preview
extension ContentView {
    func defaultPreview() -> some View {
        WBQRScanner {
            WBQRScanPreview(results: $results)
        } scanResults: { results in
            self.results = results
            defaultLinkActive.toggle()
        }
    }
}

// MARK: - Customize Preview
extension ContentView {
    func customizePreview() -> some View {
        WBQRScanner {
            VStack(spacing: 20) {
                // text
                Text("This is customize preview")
                    .foregroundColor(.white)
                
                // dismiss
                Button {
                    customizeLinkActive.toggle()
                } label: {
                    Text("Dismiss")
                }
            }
        } scanResults: { results in
            self.results = results
            customizeLinkActive.toggle()
        }
    }
}

#Preview {
    ContentView()
}
