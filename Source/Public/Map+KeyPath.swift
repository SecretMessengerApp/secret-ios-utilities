//
//

import Foundation

extension Sequence {
    public func map<Value>(_ keyPath: KeyPath<Element, Value>) -> [Value] {
        return map { $0[keyPath: keyPath] }
    }

    public func flatMap<Value>(_ keyPath: KeyPath<Element, [Value]>) -> [Value] {
        return flatMap { $0[keyPath: keyPath] }
    }

    public func compactMap<Value>(_ keyPath: KeyPath<Element, Value?>) -> [Value] {
        return compactMap { $0[keyPath: keyPath] }
    }

    public func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
        return filter { $0[keyPath: keyPath] }
    }

    public func any(_ keyPath: KeyPath<Element, Bool>) -> Bool {
        return any { $0[keyPath: keyPath] }
    }

    public  func all(_ keyPath: KeyPath<Element, Bool>) -> Bool {
        return all { $0[keyPath: keyPath] }
    }
}


extension Optional {
    public func map<Value>(_ keyPath: KeyPath<Wrapped, Value>) -> Value? {
        return map { $0[keyPath: keyPath] }
    }

    public func flatMap<Value>(_ keyPath: KeyPath<Wrapped, Value?>) -> Value? {
        return flatMap { $0[keyPath: keyPath] }
    }
}
