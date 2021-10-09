//
//


import Foundation

@objcMembers
public class SelfUnregisteringNotificationCenterToken : NSObject {
    
    private let token : Any
    
    deinit {
        NotificationCenter.default.removeObserver(token)
    }
    
    public init(_ token : Any) {
        self.token = token
    }
    
}
