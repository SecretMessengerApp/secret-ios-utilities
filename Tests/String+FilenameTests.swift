//
//

import XCTest


class String_FilenameTests: XCTestCase {
    
    func testShortUserNameToFileName() {
        // GIVEN
        let username = "John Smith"
        let filename = username.normalizedFilename.trimmedFilename(numReservedChar: 0)
        
        // WHEN & THEN
        XCTAssertEqual(filename, "John-Smith")
    }

    func testEmojiUserNameWithUUIDPrefixAndExtensionToFileName() {
        // GIVEN
        let username = "🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰"
        let filename = username.normalizedFilename.trimmedFilename(numReservedChar: 0)
        let uuidString = UUID.create().uuidString
        let exampleFileName = uuidString + "_" + filename + ".mp4"
        
        // WHEN & THEN
        XCTAssertEqual(exampleFileName.count, 255)
    }

    func testEmojiUserNameWithUUIDPrefixAndAndSubfixAndExtensionToFileName() {
        // GIVEN
        let username = "🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰🇭🇰"
        let suffix = "_dummy_date_stamp"
        let filename = username.normalizedFilename.trimmedFilename(numReservedChar: suffix.count)
        let uuidString = UUID.create().uuidString
        let exampleFileName = uuidString + "_" + filename + suffix + ".mp4"
        
        // WHEN & THEN
        XCTAssertEqual(exampleFileName.count, 255)
    }

    func testChineseUserNameToLatinFileName() {
        // GIVEN
        let username = "使用者"
        let filename = username.normalizedFilename.trimmedFilename(numReservedChar: 0)
        
        // WHEN & THEN
        XCTAssertEqual(filename, "shi-yong-zhe")
    }

    func testArabicToFileName() {
        // GIVEN
        let username = "الأشخاص المفضلين"

        let filename = username.normalizedFilename.trimmedFilename(numReservedChar: 0)
        
        // WHEN & THEN
        XCTAssertEqual(filename, "alashkhas-almfdlyn")
    }

}
