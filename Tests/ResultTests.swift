//
//

import XCTest
import WireUtilities

class ResultTests: XCTestCase {
    func testThatItCanMapAResult_Success() {
        // Given
        let sut = Result<Int>.success(42)
        
        // When
        let transformed = sut.map(String.init)
        
        // Then
        XCTAssertEqual(transformed.value, "42")
    }
    
    func testThatItCanMapAResult_Throwing() {
        // Given
        let error = NSError(domain: "", code: 0, userInfo: nil)
        let sut = Result<Int>.success(42)
        
        // When
        let transformed = sut.map { _ in throw error }
        
        // Then
        XCTAssertEqual(transformed.error as NSError?, error)
    }
    
    func testThatItCanMapAResult_Error() {
        // Given
        let error = NSError(domain: "", code: 0, userInfo: nil)
        let sut = Result<Int>.failure(error)
        
        // When
        let transformed = sut.map(String.init)
        
        // Then
        XCTAssertEqual(transformed.error as NSError?, error)
    }
    
    func testThatItReturnsAVoidResultForAGenericResult() {
        // Given
        let sut = Result<Int>.success(42)
        
        // When
        let transformed = VoidResult(result: sut)
        
        // Then
        XCTAssertNil(transformed.error)
    }

    func testThatItReturnsAVoidResultForAGenericResult_Error() {
        // Given
        let error = NSError(domain: "", code: 0, userInfo: nil)
        let sut = Result<Int>.failure(error)
        
        // When
        let transformed = VoidResult(result: sut)
        
        // Then
        XCTAssertEqual(transformed.error as NSError?, error)
    }
    
    func testThatItCanInitializeAVoidResultFromAnError() {
        // Given
        let error = NSError(domain: "", code: 0, userInfo: nil)
        
        // When
        let result = VoidResult(error: error)
        
        // Then
        XCTAssertEqual(result.error as NSError?, error)
    }
    
    func testThatItCanInitializeAVoidResultFromAnError_Nil() {
        // When & Then
        XCTAssertNil(VoidResult(error: nil).error)
    }

}
