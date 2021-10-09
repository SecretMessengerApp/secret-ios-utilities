//
//


import Foundation


public extension NSOrderedSet {
    
    func subtracting(orderedSet: NSOrderedSet) -> NSOrderedSet {
        let mutableSelf = mutableCopy() as! NSMutableOrderedSet
        mutableSelf.minus(orderedSet)
        return NSOrderedSet(orderedSet: mutableSelf)
    }
    
    func adding(orderedSet: NSOrderedSet) -> NSOrderedSet {
        let mutableSelf = mutableCopy() as! NSMutableOrderedSet
        mutableSelf.union(orderedSet)
        return NSOrderedSet(orderedSet: mutableSelf)
    }
}

