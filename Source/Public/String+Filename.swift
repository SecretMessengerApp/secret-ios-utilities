//
//


import Foundation

public extension String {
    static private let transforms = [kCFStringTransformToLatin, kCFStringTransformStripCombiningMarks, kCFStringTransformToUnicodeName]
    
    /// Convert to a POSIX "Fully portable filenames" (only allow A–Z a–z 0–9 . _ -)
    /// Space will be converted to underscore first.
    var normalizedFilename: String {
        let ref = NSMutableString(string: self) as CFMutableString
        type(of: self).transforms.forEach { CFStringTransform(ref, nil, $0, false) }
        
        let retString = (ref as String).replacingOccurrences(of: " ", with: "-")
        
        let characterSet = NSMutableCharacterSet() //create an empty mutable set
        characterSet.formUnion(with: CharacterSet.alphanumerics)
        characterSet.addCharacters(in: "_-.")
        
        let unsafeChars = characterSet.inverted
        let strippedString = retString.components(separatedBy: unsafeChars).joined(separator: "")
        
        return strippedString
    }
    
    
    /// return a filename with length <= 255 characters with additional number of characters to reserve
    ///
    /// - Parameter numReservedChar: number for characters to reserve. It should < 255 and >= 0.
    /// - Returns: trimmed filename with length <= (255 - 5 - 37 - numReservedChar)
    func trimmedFilename(numReservedChar: Int) -> String {
        // reserve 5 characters for dash and file extension, 37 char for UUID prefix
        let offset = -(normalizedFilename.count - 255 + numReservedChar + 4 + 37)
        
        if offset > 0 {
            return String(self)
        }
        
        let start = normalizedFilename.startIndex
        
        let end = normalizedFilename.index(normalizedFilename.endIndex, offsetBy: offset)
        let result = normalizedFilename[start..<end]
        return String(result)
    }
}
