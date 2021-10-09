//
//


import Foundation

@objc public enum ZMManagedObjectValidationErrorCode: Int, Error {
    case tooLong
    case tooShort
    case emailAddressIsInvalid
    case phoneNumberContainsInvalidCharacters
}

public protocol ZMPropertyValidator {
    static func validateValue(_ ioValue: AutoreleasingUnsafeMutablePointer<AnyObject?>!) throws
}
