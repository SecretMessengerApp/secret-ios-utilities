//
//


public extension IteratorProtocol {

    mutating func any(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        guard let current = next() else { return false }
        return try predicate(current) || any(predicate)
    }

    mutating func all(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        guard let current = next() else { return true }
        return try predicate(current) && all(predicate)
    }

}


public extension Sequence {
    func any(_ predicate: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        var iterator = makeIterator()
        return try iterator.any(predicate)
    }

     func all(_ predicate: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        var iterator = makeIterator()
        return try iterator.all(predicate)
    }
}
