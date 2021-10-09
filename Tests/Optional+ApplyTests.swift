//
//


import XCTest


final class Optional_ApplyTests: XCTestCase {

    func testThatItExecutesTheBlockIfSelfIsSome() {
        // given
        let sut: Int? = 42
        var closurePrameter: Int?

        // when
        sut.apply {
            closurePrameter = $0
        }

        // then
        XCTAssertEqual(closurePrameter, 42)
    }

    func testThatItDoesNotExecuteTheBlockIfSelfIsNone() {
        // given
        let sut: Int? = nil

        // then
        sut.apply { _ in
            XCTFail()
        }
    }

}
