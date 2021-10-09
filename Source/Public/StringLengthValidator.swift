//
//


import Foundation

@objcMembers open class StringLengthValidator: NSObject {
    
    private static let controlSet: CharacterSet = {
        var controlSet = CharacterSet.controlCharacters
        controlSet.remove(Unicode.Scalar(0x200d)!)
        return controlSet
    }()
    
    public class StringLengthError: NSError {
        static let tooShort = StringLengthError(domain: ZMObjectValidationErrorDomain,
                                                code: ZMManagedObjectValidationErrorCode.tooShort.rawValue,
                                                userInfo: nil)
        
        static let tooLong = StringLengthError(domain: ZMObjectValidationErrorDomain,
                                               code: ZMManagedObjectValidationErrorCode.tooLong.rawValue,
                                               userInfo: nil)
    }
    
    @objc(validateValue:minimumStringLength:maximumStringLength:maximumByteLength:error:)
    public static func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>!,
                                     minimumStringLength: UInt32,
                                     maximumStringLength: UInt32,
                                     maximumByteLength: UInt32) throws {
        var pointee = ioValue.pointee as Any?
        defer { ioValue.pointee = pointee as AnyObject? }
        try validateStringValue(&pointee, minimumStringLength: minimumStringLength, maximumStringLength: maximumStringLength, maximumByteLength: maximumByteLength)
    }
    
    @discardableResult static public func validateStringValue(_ ioValue: inout Any?,
                                     minimumStringLength: UInt32,
                                     maximumStringLength: UInt32,
                                     maximumByteLength: UInt32) throws -> Bool {
        guard let string = ioValue as? String else {
            throw StringLengthError.tooShort
        }

        var trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)

        // check the trimmedString contains controlSet characters and replace matchings with spaces

        trimmedString = trimmedString
            .map{ $0.isEmoji || !$0.contains(anyCharacterFrom: controlSet) ? String($0) : " " }
            .joined()

        if trimmedString.count < minimumStringLength {
            throw StringLengthError.tooShort
        }
        
        if trimmedString.count > maximumStringLength {
            throw StringLengthError.tooLong
        }
        
        if trimmedString.utf8.count > maximumByteLength {
            throw StringLengthError.tooLong
        }
        
        if string != trimmedString {
            ioValue = trimmedString
        }
        
        return true
    }
    
}
