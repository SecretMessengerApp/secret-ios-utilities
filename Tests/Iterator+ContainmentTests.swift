//
//


import XCTest


class IteratorContainmentTests: XCTestCase {

    func testThatItReturnsFalseForAnyInEmptySequence() {
        XCTAssertFalse([].any { _ in return true } )
    }

    func testThatItReturnsTrueForAllInEmptySequence() {
        XCTAssertTrue([].all { _ in return false } )
    }

    func testThatItReturnsTrueIfThereIsAnElementThatMatchesAny() {
        XCTAssertTrue([false, true].any { $0 })
    }

    func testThatItReturnsFalseIfThereIsNoElementThatMatchesAny() {
        XCTAssertFalse([false, false].any { $0 })
    }

    func testThatItReturnsFalseIfThereIsNoElementThatMatchesAll() {
        XCTAssertFalse([false, true].all { $0 })
    }

    func testThatItReturnsFalseIfAllElementsMatchAll() {
        XCTAssertTrue([true, true].all { $0 })
    }

}
