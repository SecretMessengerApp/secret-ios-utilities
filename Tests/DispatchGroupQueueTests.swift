//
//

import WireTesting
@testable import WireUtilities

class DispatchGroupQueueTests: ZMTBaseTest {
    
    var sut: DispatchGroupQueue!
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testPerformedGroupedBlockEntersAndLeavesAllGroups() {
        // given
        let groupIsEmpty = expectation(description: "group1 is emtpy")
        let group = ZMSDispatchGroup(label: "group1")!
        sut = DispatchGroupQueue(queue: DispatchQueue.main)
        sut.add(group)
        
        // when
        sut.performGroupedBlock {
            self.sut.dispatchGroup.notify(on: DispatchQueue.main, block: {
                groupIsEmpty.fulfill()
            })
        }
        
        // then
        XCTAssertTrue(waitForCustomExpectations(withTimeout: 0.5))
    }
    
}
