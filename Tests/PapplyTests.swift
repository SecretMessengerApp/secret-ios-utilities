//
//

import XCTest

final class PartialApplicationTests: XCTestCase {
    func testThatItPartiallyApplies_1ParameterFunction() {
        // Given
        let foo: (String) -> String = { $0 }
        
        // When
        let partial = papply(foo, "1")
        
        // Then
        XCTAssertEqual(partial(), "1")
    }
    
    func testThatItPartiallyApplies_2ParameterFunction() {
        // Given
        let foo: (String, String) -> String = { $0 + $1 }
        
        // When
        let partial = papply(foo, "1")
        
        // Then
        XCTAssertEqual(partial("2"), "12")
    }
    
    func testThatItPartiallyApplies_3ParameterFunction() {
        // Given
        let foo: (String, String, String) -> String = { $0 + $1 + $2 }
        
        // When
        let partial = papply(foo, "1")
        
        // Then
        XCTAssertEqual(partial("2", "3"), "123")
    }
    
    func testThatItPartiallyApplies_4ParameterFunction() {
        // Given
        let foo: (String, String, String, String) -> String = { $0 + $1 + $2 + $3 }
        
        // When
        let partial = papply(foo, "1")
        
        // Then
        XCTAssertEqual(partial("2", "3", "4"), "1234")
    }
    
    func testThatItPartiallyApplies_5ParameterFunction() {
        // Given
        let foo: (String, String, String, String, String) -> String = { $0 + $1 + $2 + $3 + $4 }
        
        // When
        let partial = papply(foo, "1")
        
        // Then
        XCTAssertEqual(partial("2", "3", "4", "5"), "12345")
    }
    
}
