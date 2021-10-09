//
//

import Foundation

/**
 * The result of password validation.
 */

public enum PasswordValidationResult: Equatable {

    /// The password is valid.
    case valid

    /// The password is too short.
    case tooShort

    /// The password is too long.
    case tooLong

    /// The password contains a disallowed character.
    case disallowedCharacter(Unicode.Scalar)

    /// The password does not satisfy a requirement for a character class.
    case missingRequiredClasses(Set<PasswordCharacterClass>)

}
