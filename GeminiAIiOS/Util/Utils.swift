//
//  Utils.swift
//  GeminiAIiOS
//
//  Created by @TechHabiles on 31/12/23.
//

import Foundation
import SwiftUI

// Custome Color, More Colors can be added to this
struct CustomColor {
    static let THCOLOR: Color = Color(UIColor(hexString: "#265AC7"))
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

/*
 * UIImage extension for reducing image size
 */
extension UIImage {
    enum ImageQuality: CGFloat {
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case best = 1
    }

    func jpeg(_ quality: ImageQuality) -> UIImage {
        guard let data =  jpegData(compressionQuality: quality.rawValue) else {
            return UIImage()
        }
        return UIImage(data: data) ?? UIImage()
    }
}
