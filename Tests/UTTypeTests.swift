// 
// 


import XCTest
import WireUtilities
#if os(iOS)
import MobileCoreServices;
#endif

class UTTypeTests: XCTestCase {

    func testThatItConvertsFromMIMEType() {
        // MIME to UTType
        guard let mp4Type = UTType(mimeType: "video/mp4") else {
            return XCTFail("Could not decode from MIME type.")
        }

        XCTAssertNotNil(mp4Type)
        XCTAssertEqual(mp4Type, UTType(kUTTypeMPEG4))
        XCTAssertTrue(mp4Type == kUTTypeMPEG4)
        XCTAssertTrue(mp4Type.conformsTo(kUTTypeMovie))
        XCTAssertFalse(mp4Type.conformsTo(UTType(kUTTypeAudio)))

        // Details
        XCTAssertNotNil(mp4Type.localizedDescription)

        // UTType to file extension
        XCTAssertEqual(mp4Type.mimeType, "video/mp4")
    }

    func testThatItConvertsFromFileExtension() {
        // File extension to UTType
        guard let mp4Type = UTType(fileExtension: "mp4") else {
            return XCTFail("Could not decode from file extension.")
        }

        XCTAssertNotNil(mp4Type)
        XCTAssertEqual(mp4Type, UTType(kUTTypeMPEG4))
        XCTAssertTrue(mp4Type == kUTTypeMPEG4)
        XCTAssertTrue(mp4Type.conformsTo(kUTTypeMPEG4))
        XCTAssertFalse(mp4Type.conformsTo(UTType(kUTTypeAudio)))

        // Details
        XCTAssertNotNil(mp4Type.localizedDescription)

        // UTType to file extension
        XCTAssertEqual(mp4Type.fileExtension, "mp4")
    }

}
