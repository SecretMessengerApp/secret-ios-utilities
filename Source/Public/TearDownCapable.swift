//
//

import Foundation

/// Object that can be torn down when not needed anymore
@objc
public protocol TearDownCapable: NSObjectProtocol {
    
    @objc
    func tearDown()
    
}
