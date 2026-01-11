import SwiftUI
import UIKit
import CoreImage.CIFilterBuiltins

enum IDNectCodeGenerator {
    static func generate(from string: String, type: IDNectCodeType, size: CGSize, foregroundColor: Color, backgroundColor: Color) -> UIImage {
        let context = CIContext()

        switch type {
        case .qr:
            let filter = CIFilter.qrCodeGenerator()
            filter.message = Data(string.utf8)
            guard let outputImage = filter.outputImage else {
                return UIImage(systemName: "xmark.circle") ?? UIImage()
            }
            let scaleX = size.width / outputImage.extent.size.width
            let scaleY = size.height / outputImage.extent.size.height
            let scaled = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            if let cgImage = context.createCGImage(scaled, from: scaled.extent) {
                return UIImage(cgImage: cgImage)
            }
        case .code128:
            let filter = CIFilter.code128BarcodeGenerator()
            filter.message = Data(string.utf8)
            guard let outputImage = filter.outputImage else {
                return UIImage(systemName: "xmark.circle") ?? UIImage()
            }
            let scaleX = size.width / outputImage.extent.size.width
            let scaleY = size.height / outputImage.extent.size.height
            var scaled = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

            if let colorFilter = CIFilter(name: "CIFalseColor") {
                colorFilter.setValue(scaled, forKey: kCIInputImageKey)
                colorFilter.setValue(CIColor(color: UIColor(foregroundColor)), forKey: "inputColor0")
                colorFilter.setValue(CIColor(color: UIColor(backgroundColor)), forKey: "inputColor1")
                if let colored = colorFilter.outputImage {
                    scaled = colored
                }
            }

            if let cgImage = context.createCGImage(scaled, from: scaled.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
