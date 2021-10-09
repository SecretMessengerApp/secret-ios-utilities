//
//

import XCTest

final class CurryingTests: XCTestCase {

    func testThatItCurries_1ParameterFunction() {
        // Given
        let foo: (Int) -> Int = { $0 }
        
        // When
        let curried = curry(foo)
        
        // Then
        XCTAssertEqual(curried(4), 4)
    }
    
    func testThatItCurries_2ParameterFunction() {
        // Given
        let add: (String, String) -> String = { $0 + $1 }
        
        // When
        let curried = curry(add)
        
        // Then
        XCTAssertEqual(curried("Hello")(" World"), "Hello World")
    }
    
    func testThatItCurries_3ParameterFunction() {
        // Given
        let foo: (String, String, String) -> String = { $0 + $1 + $2 }
        
        // When
        let curried = curry(foo)
        
        // Then
        XCTAssertEqual(curried("1")("2")("3"), "123")
    }
    
    func testThatItCurries_4ParameterFunction() {
        // Given
        let foo: (String, String, String, String) -> String = { $0 + $1 + $2 + $3 }
        
        // When
        let curried = curry(foo)
        
        // Then
        XCTAssertEqual(curried("1")("2")("3")("4"), "1234")
    }
    
    func testThatItCurries_5ParameterFunction() {
        // Given
        let foo: (String, String, String, String, String) -> String = { $0 + $1 + $2 + $3 + $4 }
        
        // When
        let curried = curry(foo)
        
        // Then
        XCTAssertEqual(curried("1")("2")("3")("4")("5"), "12345")
    }
    
    func testThatItCurries_6ParameterFunction() {
        // Given
        let foo: (String, String, String, String, String, String) -> String = { $0 + $1 + $2 + $3 + $4 + $5 }
        
        // When
        let curried = curry(foo)
        
        // Then
        XCTAssertEqual(curried("1")("2")("3")("4")("5")("6"), "123456")
    }

}
