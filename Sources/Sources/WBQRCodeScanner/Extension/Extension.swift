//
//  WBQRScanner.swift
//  WBQRCodeScanner
//
//
//  Created by WBear on 2024/7/4.
//

import Foundation
import SwiftUI

public extension EnvironmentValues {
    // this can be used as: @Environment(\.dismissable) var dismiss
    // in any swiftui view and it will not complain about ios versions
    var dismissable: () -> Void {
        return dismissAction
    }
    

    // this function abstracts the availability check so you can
    // avoid the conflicting return types and any other headache
    private func dismissAction() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
