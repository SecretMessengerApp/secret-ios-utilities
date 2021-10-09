//
//

import UIKit

public extension UIColor {
    /// Init a UIColor with RGB 24-bit value and alpha value
    ///
    /// - Parameters:
    ///   - rgb: a unsigned integer value form 0x000000 to 0xFFFFFF, e.g. 0x112233
    ///   - alpha: alpha value form 0 to 1
    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        let r, g, b: CGFloat
        r = CGFloat(rgb >> 16 & 0xFF) / 255.0
        g = CGFloat(rgb >> 8 & 0xFF) / 255.0
        b = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    var alpha: CGFloat {
        get {
            var alpha: CGFloat = 0
            guard self.getRed(nil, green: nil, blue: nil, alpha: &alpha) else {
                return 0
            }
            
            return alpha
        }
    }
    
}
