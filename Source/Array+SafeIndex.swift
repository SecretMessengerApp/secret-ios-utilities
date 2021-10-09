//
//

import Foundation

extension Collection {

    /**
     * Returns the element at the specified index, if it is valid.
     * - parameter index: The index to query.
     * - returns: The element at the index, of `nil` if the index is out of bounds.
     */

    public func element(atIndex index: Index) -> Element? {
        guard index >= startIndex, index < endIndex else {
            return nil
        }

        return self[index]
    }

}
