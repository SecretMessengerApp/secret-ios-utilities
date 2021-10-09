//
//

import XCTest

final class ColorComponentsTests: XCTestCase {
    func testThatWhiteColorComponentsAreCorrect() {
        ///GIVEN
        let whiteColor = UIColor.white
        
        ///WHEN
        let sut = UIColor.Components(color: whiteColor)
        
        ///THEN
        XCTAssertEqual(sut.red, 1)
        XCTAssertEqual(sut.green, 1)
        XCTAssertEqual(sut.blue, 1)
        XCTAssertEqual(sut.alpha, 1)
    }
    
    func testThatRedColorComponentsAreCorrect() {
        ///GIVEN
        let redColor = UIColor.red
        
        ///WHEN
        let sut = UIColor.Components(color: redColor)
        
        ///THEN
        XCTAssertEqual(sut, redColor.components)
    }

    func testThatColorCanNotBeCompareDirectly() {
        XCTAssertNotEqual(UIColor.black, UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    }

    func testThatColorIsComparableWithEqualSign() {
        XCTAssert(UIColor.black == UIColor(red: 0, green: 0, blue: 0, alpha: 1))
    }

    func testThatColorCanBeInitializeWithRGBAValues() {
        let sut = UIColor(rgba:(255, 0, 0, 1))
        XCTAssertEqual(UIColor.red, sut)
    }

    func testThatColorCanBeInitializeWithRGBValues() {
        let sut = UIColor(rgb:(127.5, 0, 127.5))
        XCTAssertEqual(UIColor.purple, sut)
    }
}
