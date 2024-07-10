# WBQRCodeScanner

<p align="leading">
    <img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platforms" />
    <img src="https://img.shields.io/badge/Swift-5-orange.svg" />
    <a href="https://github.com/ThasianX/Elegant-Pages/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
		<img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg"/>
</p>

WBQRCodeSanner is QR Code Scanner in SwiftUI



<p>
  <img src="https://github.com/WBearJ/WBRepositoryResources/blob/main/WBQRCodeScanner/demo.gif?raw=true" width=300>
  <img src="https://github.com/WBearJ/WBRepositoryResources/blob/main/WBQRCodeScanner/customize.jpeg?raw=true" width=300>
</p>





## Requirements

- iOS 13.0+

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
    
    var body: some View {
        NavigationStack {
            NavigationLink {
              WBQRScanner { results in
                  self.results = results
              }
	          } label: {
              Text("Default Scan Preview")
  	        }
         		
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



## Release Note

* 0.0.1 - Basic functions
* 0.0.2 - Improve usages, add photo album recognize function



## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
