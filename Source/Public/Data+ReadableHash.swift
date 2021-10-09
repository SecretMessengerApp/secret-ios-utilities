////
//

import Foundation

extension Data {
    /// Produces a hash that is 8 characters long. It can be used to obfuscate sensitive data but still allow matching it e.g. in logs.
    public var readableHash: String {
        let hash = zmSHA256Digest().zmHexEncodedString()
        return String(hash.prefix(8))
    }
}
