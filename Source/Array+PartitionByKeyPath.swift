//
//

import Foundation

extension Array {
    
    public func partition<Key>(by keyPath: KeyPath<Element, Key?>) -> [Key: [Element]] {
        return reduce(into: [:], { (result, element) in
            if let key = element[keyPath: keyPath] {
                if let partition = result[key] {
                    result[key] = partition + [element]
                } else {
                    result[key] = [element]
                }
            }
        })
    }
    
    public func partition<Key>(by keyPath: KeyPath<Element, Key>) -> [Key: [Element]] {
        return reduce(into: [:], { (result, element) in
            let key = element[keyPath: keyPath]
            
            if let partition = result[key] {
                result[key] = partition + [element]
            } else {
                result[key] = [element]
            }
        })
    }
    
}
