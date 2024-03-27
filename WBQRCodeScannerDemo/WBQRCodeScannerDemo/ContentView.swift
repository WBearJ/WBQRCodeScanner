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
    
    @State var scannerActive = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(
                    destination: WBQRScanner {
                                    WBQRScanPreview(results: $results)
                                } scanResults: { results in
                                    self.results = results
                                    scannerActive.toggle()
                                },
                    isActive: $scannerActive,
                    label: {
                        Text("Scan")
                    })
                
                ForEach(results, id: \.stringValue) { result in
                    Text("Scan Value: \(result.stringValue ?? "")")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
