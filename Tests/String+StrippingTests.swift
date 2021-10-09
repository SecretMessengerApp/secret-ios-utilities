//
//

import XCTest

class String_StrippingTests: XCTestCase {
    
    // MARK: - Mutating method
    
    func testThatItStripsSingleCharacter() {
        // given
        var sut = "abc"
        
        // when
        sut.stripPrefix("a")
        
        // then
        XCTAssertEqual(sut, "bc")
    }
    
    func testThatItStripsMultipleCharacters() {
        // given
        var sut = "abc"
        
        // when
        sut.stripPrefix("ab")
        
        XCTAssertEqual(sut, "c")
    }
    
    func testThatItStripsTheCompleteString() {
        // given
        var sut = "abc"
        
        // when
        sut.stripPrefix("abc")
        
        // then
        XCTAssertEqual(sut, "")
    }
    
    func testThatItReturnOriginalStringIfItDoesNotHavePrefix() {
        // given
        var sut = "abc"
        
        // when
        sut.stripPrefix("b")
        
        // then
        XCTAssertEqual(sut, "abc")
    }
    
    func testThatItReturnOriginalStringIfItDoesNotHaveCompletePrefix() {
        // given
        var sut = "abc"
        
        // when
        sut.stripPrefix("abcd")
        
        // then
        XCTAssertEqual(sut, "abc")
    }
    
    // MARK: - Non mutating methods
    
    func testThatItStripsLeadingAtSign() {
        XCTAssertEqual("@abc".strippingLeadingAtSign(), "abc")
    }
    
    func testThatItStripsPrefixNonMutating() {
        XCTAssertEqual("abc".strippingPrefix("a"), "bc")
    }
    
}
