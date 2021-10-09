//
//

import XCTest

final class FlipTests: XCTestCase {

    func testThatItFlips_1ParameterFunction() {
        // Given
        let foo: (String) -> String = { $0 }
        
        // When
        let flipped = flip(foo)
        
        // Then
        XCTAssertEqual(flipped("1"), "1")
    }
    
    func testThatItFlips_2ParameterFunction() {
        // Given
        let foo: (String, String) -> String = { $0 + $1 }
        
        // When
        let flipped = flip(foo)
        
        // Then
        XCTAssertEqual(flipped("2", "1"), "12")
    }
    
    func testThatItFlips_3ParameterFunction() {
        // Given
        let foo: (String, String, String) -> String = { $0 + $1 + $2 }
        
        // When
        let flipped = flip(foo)
        
        // Then
        XCTAssertEqual(flipped("3", "2", "1"), "123")
    }
    
    func testThatItFlips_4ParameterFunction() {
        // Given
        let foo: (String, String, String, String) -> String = { $0 + $1 + $2 + $3 }
        
        // When
        let flipped = flip(foo)
        
        // Then
        XCTAssertEqual(flipped("4", "3", "2", "1"), "1234")
    }
    
}
