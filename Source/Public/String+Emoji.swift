//
//

extension CharacterSet {
    static let asciiPrintableSet = CharacterSet(charactersIn: "\u{0020}!\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~")
    static let unicode = CharacterSet(charactersIn: Unicode.Scalar(Int(0x0000))! ..< Unicode.Scalar(Int(0x10FFFF))!)
    static let asciiUppercaseLetters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    static let asciiLowercaseLetters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz")
    static let asciiStandardCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
}

extension Unicode.Scalar {
    static let cancelTag: Unicode.Scalar = Unicode.Scalar(0xE007F)!

    var isEmojiComponentOrMiscSymbol: Bool {
        switch self.value {
        case 0x200D,       // Zero width joiner
        0x2139,            // the info symobol
        0x2030...0x2BFF,   // Misc symbols
        0x2600...0x27BF,   // Misc symbols, Dingbats
        0xE007F,           // cancelTag
        0xFE00...0xFE0F:   // Variation Selectors
            return true
        default:
            return false
        }
    }


    var isEmoji: Bool {
        //Unicode General Category S* contains Sc, Sk, Sm & So, we just interest on So(5855 items)
        return (CharacterSet.symbols.contains(self) && !CharacterSet.asciiPrintableSet.contains(self)) ||
            self.isEmojiComponentOrMiscSymbol
    }
    
}

extension Character {
    var isEmoji: Bool {
        for scalar in self.unicodeScalars {
            if scalar.isEmoji {
                return true
            }
        }

        return false
    }

    public func contains(anyCharacterFrom characterSet: CharacterSet) -> Bool {
        for scalar in self.unicodeScalars {
            if characterSet.contains(scalar) {
                return true
            }
        }
        return false
    }

}

extension String {
    public var containsEmoji: Bool {
        guard count > 0 else { return false }

        for char in self {
            if char.isEmoji {
                return true
            }
        }

        return false
    }

    public var containsOnlyEmojiWithSpaces: Bool {
        return components(separatedBy: .whitespaces).joined().containsOnlyEmoji
    }

    var containsOnlyEmoji: Bool {
        guard count > 0 else { return false }

        let cancelTag = Unicode.Scalar.cancelTag

        for char in self {
            // some national flags are combination of black flag and characters, and ends with Cancel Tag
            if char.unicodeScalars.contains(cancelTag) {
                continue
            }

            for scalar in char.unicodeScalars {
                if !scalar.isEmoji {
                    return false
                }
            }
        }

        return true
    }
}
