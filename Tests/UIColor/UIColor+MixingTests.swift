//
//

import XCTest

final class UIColorMixingTests: XCTestCase {
    func testThatBlackAndWhiteIsMixedToGrey() {
        ///GIVEN
        let whiteColor = UIColor.white
        let blackColor = UIColor.black

        ///WHEN
        let sut = whiteColor.mix(blackColor, amount: 0.5).components
        
        ///THEN
        XCTAssertEqual(sut.red, 0.5)
        XCTAssertEqual(sut.green, 0.5)
        XCTAssertEqual(sut.blue, 0.5)
        XCTAssertEqual(sut.alpha, 1)
    }

    func testThatBlackAndWhiteWithAlphaIsMixedToGreyWithNoAlpha() {
        ///GIVEN
        let alphaWhiteColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        let alphaBlackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        ///WHEN
        let sut = alphaWhiteColor.removeAlphaByBlending(with: alphaBlackColor).components
        
        ///THEN
        XCTAssertEqual(sut.red, 0.5)
        XCTAssertEqual(sut.green, 0.5)
        XCTAssertEqual(sut.blue, 0.5)
        XCTAssertEqual(sut.alpha, 1)
    }
}
