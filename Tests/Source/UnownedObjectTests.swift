// 
// 


import XCTest
import WireUtilities

final class UnownedObjectTests: XCTestCase {

    
    func testThatCreatingAnUnownedObjectWithALocallyScopedObjectIsValid() {
        let nsnumber = 10 as AnyObject
        let unown = UnownedObject(nsnumber)
        XCTAssertTrue(unown.isValid)
        XCTAssertEqual(10, unown.unbox! as! Int)
    }
    
    
    func testThatUnownedObjectIsInvalidIfValueDoesNotExistAnymore() {
        
        var array : Array<NSObject>? = [NSObject()]
        let unownedObject = UnownedObject(array![0] as AnyObject)
        array = nil
        XCTAssertFalse(unownedObject.isValid)
        XCTAssertNil(unownedObject.unbox)
    }
}
