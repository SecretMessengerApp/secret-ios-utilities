//
//

import XCTest
import WireUtilities

class DarwinNotificationCenterTests: XCTestCase {
    
    func testThatItInvokesHandlers() {
        // given
        let sut = DarwinNotificationCenter.shared
        let firstHandler = expectation(description: "first handler called")
        let secondHandler = expectation(description: "second handler called")
        
        sut.observe(notification: .shareExtDidSaveNote) { firstHandler.fulfill() }
        sut.observe(notification: .shareExtDidSaveNote) { secondHandler.fulfill() }
        
        // when
        DarwinNotification.shareExtDidSaveNote.post()
        
        // then
        wait(for: [firstHandler, secondHandler], timeout: 0.5)
    }
}
