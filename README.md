# WBQRCodeScanner

<p align="leading">
    <img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platforms" />
    <img src="https://img.shields.io/badge/Swift-5-orange.svg" />
    <a href="https://github.com/ThasianX/Elegant-Pages/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
		<img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg"/>
</p>

WBQRCodeSanner is a SwiftUI QR Code Scanner



<p>
  <img src="https://github.com/WBearJ/WBRepositoryResources/blob/main/WBQRCodeScanner/demo.gif?raw=true" width=300>
  <img src="https://github.com/WBearJ/WBRepositoryResources/blob/main/WBQRCodeScanner/customize.jpeg?raw=true" width=300>
</p>





## Requirements

- iOS 15.0+

- Xcode 11.0+

  

## Installation

### Swift Package Manager

Using Xcode 11, go to `File -> Swift Packages -> Add Package Dependency` and enter https://github.com/WBearJ/WBQRCodeScanner.git



## Usage

⚠️ Before use, add camera usage description to your `info.plist`

```xml
<key>NSCameraUsageDescription</key>
<string>app needs access to the camera to scan the qr code</string>
```





That's a basic example. use the default camera preview

```swift
import SwiftUI
import WBQRCodeScanner

struct ContentView: View {
    
    @State var results = [WBQRBarcodeResult]()
    
    @State var qrcodeActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: scannerView(),
                    isActive: $qrcodeActive,
                    label: {
                        Text("QRCode Scan")
                    })
            }
        }
    }
  
  	func scannerView() -> some View {
        WBQRScanner {
            // defalut preview
            WBQRScanPreview(results: $results)
        } scanResults: { results in
            // do something with the results
            qrcodeActive.toggle()
        }
    }
}
```



If you want customize the preview, you just modify the  ```WBQRScanPreview```, here is the simple explore:

```swift
func scannerView() -> some View {
  
  WBQRScanner {
    	// customize preview
   	 	Text("you can customize preview here")
  } scanResults: { results in
	    // do something with the results
  }
}
```



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
