//
//

import WireTesting
@testable import WireUtilities

class DispatchGroupContextTests: ZMTBaseTest {
    
    var sut : DispatchGroupContext!
        
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testInjectGroupsAreAdded() {
        // given
        let group = ZMSDispatchGroup(label: "group1")!
        sut = DispatchGroupContext(groups: [group])
        
        // then
        XCTAssertEqual(sut.groups, [group])
    }
    
    func testGroupsCanBeAdded() {
        // given
        let group = ZMSDispatchGroup(label: "group1")!
        sut = DispatchGroupContext(groups: [])
        
        // when
        sut.add(group)
        
        // then
        XCTAssertEqual(sut.groups, [group])
    }
    
    func testGroupsCanBeEntered() {
        // given
        let group = ZMSDispatchGroup(label: "group1")!
        sut = DispatchGroupContext(groups: [group])
        
        // when
        let enteredGroups = sut.enterAll()
        
        // then
        XCTAssertEqual(enteredGroups, [group])
    }
    
    func testGroupsCanBeEnteredExcludingOne() {
        // given
        let group1 = ZMSDispatchGroup(label: "group1")!
        let group2 = ZMSDispatchGroup(label: "group2")!
        sut = DispatchGroupContext(groups: [group1, group2])
        
        // when
        let enteredGroups = sut.enterAll(except: group1)
        
        // then
        XCTAssertEqual(enteredGroups, [group2])
    }
    
    func testGroupsCanBeLeft() {
        // given
        let groupIsEmpty = expectation(description: "group did become empty")
        let group = ZMSDispatchGroup(label: "group1")!
        sut = DispatchGroupContext(groups: [group])
        let enteredGroups = sut.enterAll()
        
        // expect
        enteredGroups.first?.notify(on: DispatchQueue.main, block: {
            groupIsEmpty.fulfill()
        })
        
        // when
        sut.leaveAll()
        XCTAssertTrue(waitForCustomExpectations(withTimeout: 0.5))
    }
    
    func testSelectedGroupsCanBeLeft() {
        // given
        let group1IsEmpty = expectation(description: "group1 did become empty")
        let group2IsEmpty = expectation(description: "group2 did become empty")
        let group1 = ZMSDispatchGroup(label: "group1")!
        let group2 = ZMSDispatchGroup(label: "group2")!
        sut = DispatchGroupContext(groups: [group1, group2])
        let enteredGroups = sut.enterAll()

        // expect
        enteredGroups.first?.notify(on: DispatchQueue.main, block: {
            group1IsEmpty.fulfill()
        })
        
        enteredGroups.last?.notify(on: DispatchQueue.main, block: {
            group2IsEmpty.fulfill()
        })
        
        // when
        sut.leave([group1])
        sut.leave([group2])
        XCTAssertTrue(waitForCustomExpectations(withTimeout: 0.5))
    }
    
}
