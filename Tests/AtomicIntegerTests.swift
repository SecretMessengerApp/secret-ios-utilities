//
//

import XCTest
import WireUtilities

class AtomicIntegerTests: XCTestCase {

    func testThatItIncrementsNumber() {
        // GIVEN
        let atomicNumber = ZMAtomicInteger(integer: 10)

        // WHEN
        let incrementedValue = atomicNumber.increment()

        // THEN
        XCTAssertEqual(incrementedValue, 11)
        XCTAssertEqual(atomicNumber.rawValue, 11)
    }

    func testThatItDecrementsNumber() {
        // GIVEN
        let atomicNumber = ZMAtomicInteger(integer: 10)

        // WHEN
        let incrementedValue = atomicNumber.decrement()

        // THEN
        XCTAssertEqual(incrementedValue, 9)
        XCTAssertEqual(atomicNumber.rawValue, 9)
    }

    func testThatItSwapsValueWhenCurrentValueIsEqualToExpected() {
        // GIVEN
        let atomicNumber = ZMAtomicInteger(integer: 0)

        // WHEN
        let swapped = atomicNumber.setValueWithEqualityCondition(0, newValue: 1)

        // THEN
        XCTAssertTrue(swapped)
        XCTAssertEqual(atomicNumber.rawValue, 1)
    }

    func testThatItDoesNotSwapValueWhenCurrentValueIsNotEqualToExpected() {
        // GIVEN
        let atomicNumber = ZMAtomicInteger(integer: 1)

        // WHEN
        let swapped = atomicNumber.setValueWithEqualityCondition(0, newValue: 1)

        // THEN
        XCTAssertFalse(swapped)
        XCTAssertEqual(atomicNumber.rawValue, 1)
    }

}
