//
//

import UIKit

public extension UIColor {
    struct Components: Equatable {
        public var red: CGFloat = 0
        public var green: CGFloat = 0
        public var blue: CGFloat = 0
        public var alpha: CGFloat = 0
        
        public init(color: UIColor) {
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
    }
    
    var components: Components {
        return Components(color: self)
    }
    
    static func == (lhs: UIColor, rhs: UIColor) -> Bool {
        return lhs.components == rhs.components
    }
    
    
    /// Create a color with a tuple rgba. The range of each component is 0 to 255 and alpha is 0 to 1
    ///
    /// - Parameter rgba: tuple of color components
    convenience init(rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)) {
        
        self.init(red: rgba.red / 255,
                  green: rgba.green / 255,
                  blue: rgba.blue / 255,
                  alpha: rgba.alpha)
    }

    /// Create a color with a tuple rgba. The range of each component is 0 to 255 and alpha 1
    ///
    /// - Parameter rgba: tuple of color components
    convenience init(rgb: (red: CGFloat, green: CGFloat, blue: CGFloat)) {
        self.init(rgba: (red: rgb.red,
                         green: rgb.green,
                         blue: rgb.blue,
                         alpha: 1))
    }

}

