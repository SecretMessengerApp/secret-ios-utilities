//
//  Array+suffix.swift
//  WireUtilities
//
//  Created by wj on 2020/12/23.
//

import Foundation

public extension Array {
    
    func secretSuffix(count: Int) -> [Element] {
        guard self.count > count else {return self}
        var result = [Element]()
        let start = self.count - count
        for i in start...(self.count - 1) {
            result.append(self[i])
        }
        return result
    }
    
}
