////
//

import Foundation

extension String {
    /// Produces a hash that is 8 characters long. It can be used to obfuscate sensitive data but still allow matching it e.g. in logs.
    public var readableHash: String {
        guard let data = data(using: .utf8) else { return "n/a" }
        return data.readableHash
    }
}
