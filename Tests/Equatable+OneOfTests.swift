//
//

import XCTest
import WireUtilities

class EquatableOneOfTests : XCTestCase {

    func testThatItReportsContainmentVariadicFunction() {
        // Given
        let sut = 42
        
        // Then
        XCTAssert(sut.isOne(of: 42, 43))
    }
    
    func testThatItReportsContainmentVariadicFunction_Negative() {
        // Given
        let sut = 42
        
        // Then
        XCTAssertFalse(sut.isOne(of: 43))
    }
    
    func testThatItReportsContainmentCollectionFunction() {
        // Given
        let sut = 42
        
        // Then
        XCTAssert(sut.isOne(of: [42, 43]))
    }
    
    func testThatItReportsContainmentCollectionFunction_Empty() {
        // Given
        let sut = 42
        
        // Then
        XCTAssertFalse(sut.isOne(of: []))
    }
    
    func testThatItReportsContainmentCollectionFunction_Negative() {
        // Given
        let sut = 42
        
        // Then
        XCTAssertFalse(sut.isOne(of: [43]))
    }
    
    func testThatItReportsContainmentCollectionFunction_Set() {
        // Given
        let sut = 42
        
        // Then
        XCTAssert(sut.isOne(of: Set([42, 43, 45, 0])))
    }
}
