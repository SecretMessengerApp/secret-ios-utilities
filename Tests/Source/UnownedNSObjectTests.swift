//
// 


import XCTest
import WireUtilities

final class UnownedNSObjectTests: XCTestCase {

    func testThatCreatingAnUnownedNSObjectWithALocallyScopedObjectIsValid() {
        let unown = UnownedNSObject(NSNumber(value: 10))
        XCTAssertTrue(unown.isValid)
        XCTAssertEqual(NSNumber(value: 10), unown.unbox!)
    }
    
    
    func testThatUnownedNSObjectIsInvalidIfObjectDoesNotExistAnymore() {
        var array : Array<NSObject>? = [NSObject()]
        let unownedObject = UnownedNSObject(array![0] as NSObject)
        array = nil
        XCTAssertFalse(unownedObject.isValid)
        XCTAssertNil(unownedObject.unbox, "unownedObject.unbox = \(String(describing: unownedObject.unbox))")
    }
}
