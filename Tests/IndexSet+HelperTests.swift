//
//

import XCTest

class IndexSet_HelperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatItExcludesARange() {
        // given
        let range = 0..<10
        let excluded = [0..<5]
        
        // when
        let sut = IndexSet(integersIn: range, excluding: excluded)
        
        // then
        XCTAssertTrue(sut.contains(integersIn: IndexSet(arrayLiteral: 5, 6, 7, 8, 9)))
        XCTAssertFalse(sut.contains(integersIn: IndexSet(arrayLiteral: 0, 10)))
    }
    
    func testThatItExcludesMultipleRanges() {
        // given
        let range = 0..<10
        let excluded = [0..<5, 6..<10]
        
        // when
        let sut = IndexSet(integersIn: range, excluding: excluded)
        
        // then
        XCTAssertTrue(sut.contains(integersIn: IndexSet(arrayLiteral: 5)))
    }
    
    func testThatItDiscardsRangesOutsideMainRange() {
        // given
        let range = 0..<10
        let excluded = [6..<15]
        
        // when
        let sut = IndexSet(integersIn: range, excluding: excluded)
        
        // then
        XCTAssert(sut.count == 6)

        XCTAssert(sut.contains(integersIn: IndexSet(arrayLiteral: 0, 1, 2, 3, 4, 5)))

        XCTAssertFalse(sut.contains(integersIn: IndexSet(arrayLiteral: 9)))
        XCTAssertFalse(sut.contains(integersIn: IndexSet(arrayLiteral: 10)))
    }

}
