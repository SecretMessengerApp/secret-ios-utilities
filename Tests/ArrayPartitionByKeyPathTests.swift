//
//

import XCTest
import WireUtilities

class ArrayPartitionByKeyPathTests: XCTestCase {

    func testPartitionByOptionalValue() {
        // given
        let string1 = "hejsan"
        let string2 = "hus"
        let string3 = "bus"
        let string4 = "snus"
        let string5 = "fasan"
        let strings = [string1, string2, string3, string4, string5]
        
        // when
        let partitions = strings.partition(by: \String.last)
                
        // then
        XCTAssertEqual(partitions.count, 2)
        XCTAssertEqual(partitions["n"], [string1, string5])
        XCTAssertEqual(partitions["s"], [string2, string3, string4])
    }
    
    func testPartitionByValue() {
        // given
        let string1 = "hejsan"
        let string2 = "hus"
        let string3 = "bus"
        let string4 = "snus"
        let string5 = "fasan"
        let strings = [string1, string2, string3, string4, string5]
        
        // when
        let partitions = strings.partition(by: \String.count)
        
        // then
        XCTAssertEqual(partitions.count, 4)
        XCTAssertEqual(partitions[3], [string2, string3])
        XCTAssertEqual(partitions[4], [string4])
        XCTAssertEqual(partitions[5], [string5])
        XCTAssertEqual(partitions[6], [string1])
    }
    
}
