//
//


import XCTest


class String_EmojiTests: XCTestCase {

    func testThatItDetectsAnEmoji() {
        XCTAssertTrue("🍔".containsEmoji)
    }

    func testThatItDetectsMultipleEmoji() {
        XCTAssertTrue("🍔😜🌮🎉🍕".containsEmoji)
    }

    func testThatItDetectsAnEmojiIfItIsContainedInText() {
        XCTAssertTrue("abcdefghijklmnopqrstuv🎉wxyz_1234567890-=+'\\/`~".containsEmoji)
    }

    func testThatItDoesNotDetectAnEmojiIfThereIsNone() {
        XCTAssertFalse(" abcdefghijklmnopqrstuvwxyz_1234567890-=+'\\/`~".containsEmoji)
    }

    func testThatItDoesNotDetectAnEmojiIfThereIsNone_EmptyString() {
        XCTAssertFalse("".containsEmoji)
    }

    func testThatNonLatinsNotDetectedAsContainingEmoji() {
        XCTAssertFalse("الأشخاص المفضلين".containsEmoji)
    }

    func testThatGlagoliticNotDetectedAsContainingEmoji() {
        XCTAssertFalse("ⰀⰁ".containsEmoji)
    }

    func testThatGeorgianNotDetectedAsContainingEmoji() {
        XCTAssertFalse("ქართული".containsEmoji)
        XCTAssertFalse("Ⴀჟჯჰ".containsEmoji)
    }

    func testThatNonLatinWithEmojiIsDetectedAsContainingEmoji() {
        XCTAssertTrue("الأشخاص المفضلين🙈".containsEmoji)
    }

    func testThatNonLatinsNotDetectedAsContainingEmoji_Mandarin() {
        XCTAssertFalse("普通话/普通話".containsEmoji)
    }

    func testThatNonLatinWithEmojiIsDetectedAsContainingEmoji_Mandarin() {
        XCTAssertTrue("普通话/普通話🙈".containsEmoji)
    }
}
