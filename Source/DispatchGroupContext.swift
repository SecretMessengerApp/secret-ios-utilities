//
//

import Foundation

@objcMembers public class DispatchGroupContext : NSObject {
    
    private var isolationQueue = DispatchQueue(label: "context.isolation", attributes: [.concurrent])
    private var _groups : [ZMSDispatchGroup] = []
    
    public var groups : [ZMSDispatchGroup] {
        var groups : [ZMSDispatchGroup] = []
        isolationQueue.sync {
            groups = self._groups
        }
        return groups
    }
    
    
    init(groups: [ZMSDispatchGroup] = []) {
        super.init()
        
        isolationQueue.async(flags: .barrier) {
            self._groups = groups
        }
    }
    
    @objc(addGroup:)
    func add(_ group : ZMSDispatchGroup) {
        isolationQueue.async(flags: .barrier) {
            self._groups.append(group)
        }
    }
    
    @objc(enterAllExcept:)
    func enterAll(except group: ZMSDispatchGroup? = nil) -> [ZMSDispatchGroup] {
        let groups = self.groups.filter { $0 != group}
        
        groups.forEach {
            $0.enter()
        }
        return groups
    }
    
    @objc(leaveGroups:)
    func leave(_ groups : [ZMSDispatchGroup]) {
        groups.forEach { $0.leave() }
    }
        
    func leaveAll() {
        leave(groups)
    }

}
