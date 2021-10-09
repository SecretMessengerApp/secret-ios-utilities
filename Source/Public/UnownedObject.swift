// 
// 


import Foundation

public final class UnownedObject<T: AnyObject> {
    public weak var unbox : T?
    
    public init(_ o: T) {
        self.unbox = o
    }
    
    public var isValid: Bool { return self.unbox != nil }
}

@objcMembers
public class UnownedNSObject: NSObject {
    public weak var unbox: NSObject?
    
    public init(_ unbox: NSObject) {
        self.unbox = unbox
    }
    
    open var isValid: Bool { return self.unbox != nil }
}
