// 
// 


import Foundation
import CoreData

public struct SwiftDebugging {
    
    public static func address(_ object: AnyObject) -> Int {
        return unsafeBitCast(object, to: Int.self)
    }
    
    public static func pointerDescription(_ object: NSManagedObject) -> String {
        return "<\(type(of: object)) 0x\(String(self.address(object), radix:16))>"
    }
    
    public static func sequenceDescription<T>(_ sequence : AnySequence<T>) -> String {
        
        return "( " + sequence.map({ obj -> String in self.shortDescription(obj) + ", " })
            .reduce("", +) + " )"
    }
    
    public static func sequenceDescription<S : Sequence>(_ sequence : S) -> String {
        
        return "( " + sequence.map( { obj -> String in self.shortDescription(obj) + ", " })
            .reduce("", +) + " )"
    }
    
    
    public static func shortDescription(_ value: Any) -> String {
        switch (value) {
        case let managedObject as NSManagedObject:
            return pointerDescription(managedObject)
        case let collection as AnySequence<Any>:
            return sequenceDescription(collection)
        default:
            return "\(value)"
        }
    }
}
