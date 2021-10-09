//
//

import XCTest

class FixedWidthInteger_RandomTests: XCTestCase {
    
    func testThatTheGeneratedNumberIsInRangeWithUInt() {
        
        let upperBound: UInt = 2
        let range = 0..<upperBound
        
        for _ in 0..<100 {
            XCTAssertTrue(range.contains(UInt.secureRandomNumber(upperBound: upperBound)))
        }
    }
    
    func testThatTheGeneratedNumberIsInRangeWithInt() {
        
        let upperBound: Int = 100
        let range = -upperBound..<upperBound
        
        for _ in 0..<100 {
            XCTAssertTrue(range.contains(Int.secureRandomNumber(upperBound: upperBound)))
        }
    }
    
    func testThatItGeneratesZeroWhenTheUpperBoundIsZeroOrOne() {
        XCTAssertEqual(UInt.secureRandomNumber(upperBound: 1), 0)
    }
    
    func testThatItGeneratesANumberWhenThenUpperBoundIsMax() {
        XCTAssertNotNil(UInt.secureRandomNumber(upperBound: UInt.max))
    }
    
    /// Tests for all numeric types inheriting from FixedWidthInteger
    /// https://developer.apple.com/documentation/swift/fixedwidthinteger#relationships
    
    func testThatItGeneratesANumberByProvidingBounds_Int() {
        XCTAssertNotNil(Int.secureRandomNumber(upperBound: Int.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_Int8() {
        XCTAssertNotNil(Int8.secureRandomNumber(upperBound: Int8.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_Int16() {
        XCTAssertNotNil(Int16.secureRandomNumber(upperBound: Int16.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_Int32() {
        XCTAssertNotNil(Int32.secureRandomNumber(upperBound: Int32.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_Int64() {
        XCTAssertNotNil(Int64.secureRandomNumber(upperBound: Int64.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_UInt() {
        XCTAssertNotNil(UInt.secureRandomNumber(upperBound: UInt.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_UInt8() {
        XCTAssertNotNil(UInt8.secureRandomNumber(upperBound: UInt8.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_UInt16() {
        XCTAssertNotNil(UInt16.secureRandomNumber(upperBound: UInt16.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_UInt32() {
        XCTAssertNotNil(UInt32.secureRandomNumber(upperBound: UInt32.max))
    }
    
    func testThatItGeneratesANumberByProvidingBounds_UInt64() {
        XCTAssertNotNil(UInt64.secureRandomNumber(upperBound: UInt64.max))
    }
}
