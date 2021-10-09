// 
// 


import Foundation
import Swift


/// START https://gist.github.com/anonymous/9bb5f5d9f6918b1482b6
/// Taken from that gist & slightly adapted.
public struct SetGenerator<Element : Hashable> : IteratorProtocol {
    var dictGenerator : DictionaryIterator<Element, Void>
    
    public init(_ d : Dictionary<Element,Void>) {
        dictGenerator = d.makeIterator()
    }
    
    public mutating func next() -> Element? {
        if let tuple = dictGenerator.next() {
            let (k, _) = tuple
            return k
        } else {
            return nil
        }
    }
}

// MARK: Set
extension Set {
    
    /// Returns a set with elements filtered out
    func filter(_ includeElement: (Element) -> Bool)-> Set<Element> {
        return Set(Array(self).filter(includeElement))
    }
    
    func reduce<U>(_ initial: U, combine: (U, Element) -> U) -> U {
        return Array(self).reduce(initial, combine)
    }
    
    /// Returns a set with mapped elements. The resulting set might be smaller than self because
    /// of collisions in the mapping.
    func map<U>(_ transform: (Element) -> U) -> Set<U> {
        return Set<U>(Array(self).map(transform))
    }

    var allObjects: [Element] { return Array(self) }
}

/// Make NSSet more Set like:
extension NSSet {
    @objc public func union(_ s: NSSet) -> NSSet {
        let r = NSMutableSet(set: s)
        r.union(self as Set<NSObject>)
        return r
    }
    
    @objc public var isEmpty: Bool {
        return count == 0
    }
}
