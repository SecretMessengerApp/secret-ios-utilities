//
//


import XCTest
import WireTesting

class OptionalComparisonTests: XCTestCase {
    
    func testThatItComparesTwoOptionalsGreaterThanAndLessThan() {
        // given
        let operands: [(Int?, Int?, Bool)] = [
            (1, 2, false),
            (2, 1, true),
            (nil, 0, false),
            (nil, 1, false),
            (0, nil, true),
            (2, nil, true)
        ]
        
        // then
        operands.forEach { (lhs, rhs, expected) in
            XCTAssertEqual(lhs > rhs, expected, "Comparison failed, expected \(String(describing: lhs)) to be greater than \(String(describing: rhs))")
            XCTAssertEqual(lhs < rhs, !expected, "Comparison failed, expected \(String(describing: lhs)) to be less than \(String(describing: rhs))")
        }
    }
    
    func testOptionalComparisonWhenBothOperandsAreNil() {
        let lhs: Int? = nil
        let rhs: Int? = nil
        
        XCTAssertFalse(lhs > rhs)
        XCTAssertFalse(lhs < rhs)
    }
}
