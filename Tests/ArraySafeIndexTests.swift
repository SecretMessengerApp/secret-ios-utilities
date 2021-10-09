//
//

import XCTest
import WireUtilities

class ArraySafeIndexTests: XCTestCase {

    var array: [Int]!

    override func setUp() {
        super.setUp()
        array = [1, 2, 3, 4, 5]
    }

    override func tearDown() {
        array = nil
        super.tearDown()
    }

    func testThatItReturnsFirstValue() {
        XCTAssertEqual(array.element(atIndex: 0), 1)
    }

    func testThatItReturnsInsideValue() {
        XCTAssertEqual(array.element(atIndex: 2), 3)
    }

    func testThatItReturnsLastValue() {
        XCTAssertEqual(array.element(atIndex: 4), 5)
    }

    func testThatItFailsWithLowerOutOfBoundsIndex() {
        XCTAssertNil(array.element(atIndex: -1))
    }

    func testThatItFailsWithHigherOutOfBoundsIndex() {
        XCTAssertNil(array.element(atIndex: 5))
    }

}
