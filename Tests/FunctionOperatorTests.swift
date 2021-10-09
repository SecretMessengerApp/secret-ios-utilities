//
//

import XCTest

final class FunctionOperatorTests: XCTestCase {

    func testThaItNegatesABooleanTestFunction() {
        // given
        let foo: (Bool) -> Bool = { return $0 }
        
        // when
        let negated = !foo
        
        // then
        XCTAssert(foo(true))
        XCTAssert(negated(false))
        XCTAssertFalse(negated(true))
    }

}
