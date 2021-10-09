//
//


import UIKit

@objc public class ZMAccentColorValidator: NSObject, ZMPropertyValidator {

    @objc(validateValue:error:)
    public static func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>!) throws {
        var pointee = ioValue.pointee as Any?
        defer { ioValue.pointee = pointee as AnyObject? }
        try validateValue(&pointee)
    }
    
    
    @discardableResult public static func validateValue(_ ioValue: inout Any?) throws -> Bool {
        
        let value = ioValue as? Int16
        
        if value == nil ||
            value < ZMAccentColor.min.rawValue ||
            ZMAccentColor.max.rawValue < value {
            let color = ZMAccentColor(rawValue:
                ZMAccentColor.min.rawValue +
                    Int16(arc4random_uniform(UInt32(ZMAccentColor.max.rawValue - ZMAccentColor.min.rawValue))))
            ioValue = NSNumber(value: color?.rawValue ?? 0)
        }
        
        return true
    }
    
}
