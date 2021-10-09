//
//

import Foundation

/// A wrapper class to simplify observation of Darwin Notifications.
///
public class DarwinNotificationCenter {
    
    public static var shared = DarwinNotificationCenter()
    
    public typealias Handler = () -> Void
    
    private var handlers = [DarwinNotification : [Handler]]()
    
    private init() {}
    
    /// Invokes the given handler when the given notification is fired.
    public func observe(notification: DarwinNotification, using handler: @escaping Handler) {
        defer { handlers[notification, default: []].append(handler) }
        
        // we only want to internally observe each notification once
        guard handlers[notification] == nil else { return }
        
        notification.observe { (_, _, name, _, _) in
            guard let name = name else { return }
            DarwinNotificationCenter.shared.forward(notification: name.rawValue as String)
        }
    }
    
    /// `CFNotificationCallback`s can't capture the environment, so instead we
    /// forward the fired notification name and then invoke the relevant handlers.
    func forward(notification name: String) {
        guard let notification = DarwinNotification(rawValue: name) else { return }
        handlers[notification]?.forEach { $0() }
    }
}

/// Darwin Notifications are used to communicate between an extension and the
/// containing app. Note, this "communication" is extremely limited; it is
/// simply a ping that a particular event occurred. Add a case to this enum
/// for each event you wish to post/observe.
///
public enum DarwinNotification: String {
    case shareExtDidSaveNote = "darwin-notification.share-ext-did-save-note"
    
    var name: CFNotificationName {
        return CFNotificationName(rawValue: self.rawValue as CFString)
    }
    
    func observe(using block: @escaping CFNotificationCallback) {
        // The use of Darwin Notification Center means some arguments will
        // be ignored.
        let nc = CFNotificationCenterGetDarwinNotifyCenter()
        CFNotificationCenterAddObserver(
            nc,                                 // notification center
            nil,                                // observer
            block,                              // callback
            name.rawValue,                      // notification name
            nil,                                // object (ignored)
            .deliverImmediately                 // suspension behaviour (ignored)
        )
    }
    
    public func post() {
        // The use of Darwin Notification Center means some arguments will
        // be ignored.
        let nc = CFNotificationCenterGetDarwinNotifyCenter()
        CFNotificationCenterPostNotification(
            nc,                                 // notification center
            name,                               // notification name
            nil,                                // object (ignored)
            nil,                                // user info (ignored)
            true                                // deliver immediately (ignored)
        )
    }
}
