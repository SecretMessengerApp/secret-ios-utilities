//
//

import Foundation

public extension String {
    
    mutating func stripPrefix(_ prefix: String) {
        guard hasPrefix(prefix) else { return }
        removeFirst(prefix.count)
    }
    
    func strippingPrefix(_ prefix: String) -> String {
        var modified = self
        modified.stripPrefix(prefix)
        return modified
    }

    func strippingLeadingAtSign() -> String {
        return strippingPrefix("@")
    }
    
}
