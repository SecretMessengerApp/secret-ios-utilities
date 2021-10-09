//
//


import XCTest
@testable import WireUtilities

final class UUIDtoDataConversionTests: XCTestCase {
    func testThatUUIDisConvertedToData() {
        //GIVEN
        let uuid = UUID(uuidString: "00010203-0405-0607-0809-0a0b0c0d0e0f")!

        //WHEN
        let data = uuid.uuidData

        XCTAssertEqual(data.count, 16)

        //THEN
        let bytes = [UInt8](data)
        XCTAssertEqual(bytes, [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
    }

    func testThatDataisConvertedToUUID() {
        //GIVEN
        let bytes: [UInt8] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        let data = Data(bytes)

        //WHEN
        let uuid = UUID(data: data)

        //THEN
        XCTAssertEqual(uuid, UUID(uuidString: "00010203-0405-0607-0809-0a0b0c0d0e0f"))
    }


    func testThatDataWithIncorrectLengthIsNotConverted() {
        XCTAssertNil(UUID(data: Data([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17])))
        XCTAssertNil(UUID(data: Data([0,1,2])))
    }
}
