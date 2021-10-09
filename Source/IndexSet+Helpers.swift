//
//

import Foundation

extension IndexSet {
    
    public init(integersIn range: Range<IndexSet.Element>, excluding: [Range<IndexSet.Element>]) {
        
        var excludedIndexSet = IndexSet()
        var includedIndexSet = IndexSet()
        
        excluding.forEach({ excludedIndexSet.insert(integersIn: $0) })
        includedIndexSet.insert(integersIn: range)
        
        self = includedIndexSet.subtracting(excludedIndexSet)
    }
    
}
