//
//

import Foundation

@objcMembers public class DispatchGroupQueue : NSObject, ZMSGroupQueue {
    
    let queue : DispatchQueue
    let dispatchGroupContext : DispatchGroupContext
    
    public init(queue: DispatchQueue) {
        self.queue = queue
        self.dispatchGroupContext = DispatchGroupContext(groups: [])
    }
    
    public  var dispatchGroup: ZMSDispatchGroup! {
        return self.dispatchGroupContext.groups.first
    }
    
    public func add(_ group : ZMSDispatchGroup) {
        self.dispatchGroupContext.add(group)
    }
    
    public func performGroupedBlock(_ block: @escaping () -> Void) {
        let groups = dispatchGroupContext.enterAll()
        queue.async {
            block()
            self.dispatchGroupContext.leave(groups)
        }
    }
    
}
