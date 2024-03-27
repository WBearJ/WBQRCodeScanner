//
//  WBBarcodeResult.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/26.
//

import Foundation
import AVFoundation

public struct WBQRBarcodeResult: Equatable {
    /// code type
    public var type: AVMetadataObject.ObjectType!
    
    /// code frame
    public var frame: CGRect?
    
    /// barcode value
    public var stringValue: String?
}
