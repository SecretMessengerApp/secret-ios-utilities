//
//


import XCTest
import WireUtilities


class OrderedSetTests : XCTestCase {

    func testThatItAddsValuesFromAnNSOrderedSet(){
        // given
        let set1 = NSOrderedSet(array:["a", "b"])
        let set2 = NSOrderedSet(array:["b", "c"])
        
        // when
        let joined = set1.adding(orderedSet: set2)
        
        // then
        XCTAssertEqual(joined, NSOrderedSet(array:["a", "b", "c"]))
    }
    
    func testThatItRemovesValuesFromAnNSOrderedSet(){
        // given
        let set1 = NSOrderedSet(array:["a", "b"])
        let set2 = NSOrderedSet(array:["b", "c"])
        
        // when
        let subtracted = set1.subtracting(orderedSet: set2)
        
        // then
        XCTAssertEqual(subtracted, NSOrderedSet(array:["a"]))
    }
}
