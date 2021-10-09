// 
// 


import Foundation

public struct Enumerator : Sequence {
    
    let enumerable : NSFastEnumeration
    
    public init(_ object: NSFastEnumeration) {
        self.enumerable = object
    }
    
    public func makeIterator() -> NSFastEnumerationIterator {
        return NSFastEnumerationIterator(self.enumerable)
    }
    
    /**
     /!\ Be careful using this: Tries to generate a finite array in memory out of potentially infinite enumeration /!\
     */
    public func allObjects() -> [AnyObject] {
        var array : [AnyObject] = []
        for object in self {
            array.append(object as AnyObject)
        }
        return array
    }
}
