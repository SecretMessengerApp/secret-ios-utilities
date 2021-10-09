//
//


import Foundation

// Mapping of @c NSData helper methods to Swift 3 @c Data. See original methods for description.
public extension Data {
    
    func zmMD5Digest() -> Data {
        return (self as NSData).zmMD5Digest()
    }
    
    func zmHMACSHA256Digest(key: Data) -> Data {
        return (self as NSData).zmHMACSHA256Digest(withKey: key)
    }
    
    func zmHexEncodedString() -> String {
        let hexDigits = Array("0123456789abcdef".utf16)
        var characters : [unichar] = []
        characters.reserveCapacity(count * 2)
        
        self.forEach { byte in
            characters.append(hexDigits[Int(byte / 16)])
            characters.append(hexDigits[Int(byte % 16)])
        }
        
        return String(utf16CodeUnits: characters, count: characters.count)
    }
        
    static func zmRandomSHA256Key() -> Data {
        return NSData.zmRandomSHA256Key()
    }
    
    func zmSHA256Digest() -> Data {
        return (self as NSData).zmSHA256Digest()
    }
    
    func base64String() -> String {
        return (self as NSData).base64String()
    }
    
    func zmEncryptPrefixingIV(key: Data) -> Data {
        return (self as NSData).zmEncryptPrefixingIV(withKey: key)
    }
    
    func zmDecryptPrefixedIV(key: Data) -> Data {
        return (self as NSData).zmDecryptPrefixedIV(withKey: key)
    }
    
    func zmEncryptPrefixingPlainTextIV(key: Data) -> Data {
        return (self as NSData).zmEncryptPrefixingPlainTextIV(withKey: key)
    }
    
    func zmDecryptPrefixedPlainTextIV(key: Data) -> Data? {
        return (self as NSData).zmDecryptPrefixedPlainTextIV(withKey: key)
    }
    
    static func secureRandomData(length: UInt) -> Data {
        return NSData.secureRandomData(ofLength: length)
    }
    
    static func randomEncryptionKey() -> Data {
        return NSData.randomEncryptionKey()
    }
    
}
