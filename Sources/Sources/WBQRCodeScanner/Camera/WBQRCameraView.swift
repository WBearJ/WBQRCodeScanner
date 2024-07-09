//
//  WBCameraView.swift
//  WBQRCodeScanner
//
//  Created by WBear on 2024/3/25.
//

import Foundation
import UIKit
import AVFoundation

final public class WBQRCameraView: UIView {
    
    public typealias ErrorMessage = (_ message: String) -> Void
    public typealias ScanResults = (_ results: [WBQRBarcodeResult]) -> Void
    
    /// dismiss
    var dismiss: (() -> Void)?
    /// Camera Config Error
    public var errorMessage: ErrorMessage
    /// scan result
    public var scanResults: ScanResults
    /// support barcode
    public var supportBarcode: [AVMetadataObject.ObjectType] = [.qr, .upce, .ean13, .ean8, .code39, .code39Mod43, .code93, .code128]
    
    // session
    private var captureSession: AVCaptureSession!
    // camera preview
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    var isRunning: Bool {
        captureSession.isRunning
    }
    
    convenience init(scanResluts: @escaping ScanResults, errorMessage: @escaping ErrorMessage) {
        self.init(frame: .zero, scanResluts: scanResluts, errorMessage: errorMessage)
    }
    
    init(frame: CGRect, scanResluts: @escaping ScanResults, errorMessage: @escaping ErrorMessage) {
        self.errorMessage = errorMessage
        self.scanResults = scanResluts
        super.init(frame: frame)
        #if targetEnvironment(simulator)
            errorMessage("Simulator are not support")
        #else
            checkAuthorizationStatus()
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
}

// MARK: - Check Auth Status
extension WBQRCameraView {
    private func checkAuthorizationStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            configCameraView()
        case .notDetermined:
            requestAuthorization()
        case .restricted:
            errorMessage("Authorization Restricted")
        case .denied:
            errorMessage("Authorization Denied")
        @unknown default:
            errorMessage("Unknow Error")
        }
    }
    
    private func requestAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.sync {
                if granted {
                    self.configCameraView()
                }
            }
        }
    }
}


extension WBQRCameraView {
    private func configCameraView() {
        backgroundColor = .black
        
        guard let backCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
            errorMessage("Cannot get the camera")
            return
        }
        
        do {
            captureSession = AVCaptureSession()
            
            // input
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            // output
            let output = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                output.metadataObjectTypes = supportBarcode
            }
            
            // preview layer
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer!.videoGravity = .resizeAspectFill
            layer.addSublayer(previewLayer!)
            
            DispatchQueue.main.async {
                DispatchQueue.global(qos: .background).async {
                    self.captureSession.startRunning()
                }
            }
        } catch {
            errorMessage("session error: \(error.localizedDescription)")
        }
    }
}

extension WBQRCameraView: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        
        // results
        let results = metadataObjects.compactMap { $0 as? AVMetadataMachineReadableCodeObject }.map {
            var result = WBQRBarcodeResult()
            result.type = $0.type
            result.stringValue = $0.stringValue
            result.frame = previewLayer?.transformedMetadataObject(for: $0)?.bounds
            return result
        }
        dismiss?()
        scanResults(results)
    }
}

extension WBQRCameraView {
    func stopRunning() {
        captureSession.stopRunning()
    }
}
