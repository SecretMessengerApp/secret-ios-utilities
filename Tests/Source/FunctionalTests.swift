// 
// 


import XCTest
import WireUtilities

class FunctionalTests: XCTestCase {

    func testThatTheGeneratedSwiftArrayIsSimilarToTheBaseArray() {
        
        let mutableArray = NSMutableArray()
        for i in 0 ..< 10 {
            mutableArray.add(NSNumber(value: i as Int))
        }
        let baseArray = (mutableArray.copy() as! [NSObject])
        
        let enumerator = Enumerator(mutableArray)
        let enumeratorArray = (enumerator.allObjects() as! [NSObject])
        
        XCTAssertEqual(baseArray, enumeratorArray)
    }

}
