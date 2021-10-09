//
//

import Foundation
import WireSystem

public enum ExtremeCombiningCharactersValidationError: Error {
    case containsExtremeCombiningCharacters
    case notAString
}

@objc public class ExtremeCombiningCharactersValidator: NSObject, ZMPropertyValidator {
    
    @objc(validateValue:error:)
    public static func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>!) throws {
        guard let pointee = ioValue.pointee else {
            return
        }
        
        var anyPointee: Any? = pointee as Any?
        defer { ioValue.pointee = anyPointee as AnyObject? }
        try validateCharactersValue(&anyPointee)
    }
    
    @discardableResult public static func validateCharactersValue(_ ioValue: inout Any?) throws -> Bool {
        
        guard let string = ioValue as? String else {
            throw ExtremeCombiningCharactersValidationError.notAString
        }
        
        let stringByRemovingExtremeCombiningCharacters = string.removingExtremeCombiningCharacters
        
        if string.unicodeScalars.count != stringByRemovingExtremeCombiningCharacters.unicodeScalars.count {
            ioValue = stringByRemovingExtremeCombiningCharacters as AnyObject?
            throw ExtremeCombiningCharactersValidationError.containsExtremeCombiningCharacters
        }
        return true
    }
}
