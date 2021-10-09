//
//


import Foundation
import XCTest

class EmojiOnlyStringTests: XCTestCase {
    
    func testThatCommonEmojisAreDetected() {
        // given
        let commonEmoji = ["©️", "ℹ️", "☘️", "⏰️", "➰️", "♥️", "🀄️", "🇨🇭", "⭔", "⭕",
                           "😜", "🙏", "🌝", "😘", "👍", "💩", "😂", "😍", "😁",
                           "❤︎", "❤️", "🈚︎",  "🀄︎", //emoji variation
                           "👩", "👩🏻", "👩🏼", "👩🏽", "👩🏾", "👩🏿", //Fitzpatrick modifiers
                           "👨‍👩‍👧", "🏳️‍🌈", // Joining
                           "🧘🏿‍♀️", "🧡", "🦒", "🧦", "🏴󠁧󠁢󠁷󠁬󠁳󠁿", "🧟‍♂️", ///Emoji 5.0
            // TODO: Test for Emoji 11.0 new emoji "🥮" after iOS 12.1 is released
        ]

        // then
        commonEmoji.forEach {
            XCTAssert($0.containsOnlyEmojiWithSpaces, "Failed: \($0)")
            XCTAssert($0.containsEmoji, "Failed: \($0)")
        }
    }
    
    func testThatSeveralEmojisAreDetected() {
        // given
        let commonEmojiGroups = ["😜🙏🌝😘", "👍💩😂😍", "😁💁🙌", "👯😻"]
        // then
        commonEmojiGroups.forEach {
            XCTAssertTrue($0.containsOnlyEmojiWithSpaces)
        }
    }
    
    func testThatSeveralEmojisWithSpacesAreDetected() {
        // given
        let commonEmojiGroups = ["😜      🙏 🌝 😘", "    👍💩😂😍", "😁💁🙌 ", "👯 😻"]
        // then
        commonEmojiGroups.forEach {
            XCTAssertTrue($0.containsOnlyEmojiWithSpaces, "Failed: \($0)")
        }
    }
    
    func testThatNewEmojisAreDetected() {
        // given
        let newEmoji = ["💪🏾", "🤘🏼", "👶🏼", "💅🏼"]
        // then
        newEmoji.forEach {
            XCTAssertTrue($0.containsOnlyEmojiWithSpaces, "Failed: \($0)")
        }
    }
    
    func testThatSeveralNewEmojisAreDetected() {
        // given
        let newEmojiGroups = ["💪🏾🤘🏼", "👶🏼💅🏼🤘🏼"]
        // then
        newEmojiGroups.forEach {
            XCTAssertTrue($0.containsOnlyEmojiWithSpaces, "Failed: \($0)")
        }
    }
    
    func testThatSeveralNewEmojisWithSpacesAreDetected() {
        // given
        let newEmojiGroupsWithSpaces = [" 💪🏾🤘🏼", "👶🏼 💅🏼    🤘🏼 "]
        // then
        newEmojiGroupsWithSpaces.forEach {
            XCTAssertTrue($0.containsOnlyEmojiWithSpaces, "Failed: \($0)")
        }
    }

    func testThatASCIISymbolsAreNotDetected() {
        // given
        let langaugeStrings = ["=", "+", "$"]

        // then
        langaugeStrings.forEach {
            XCTAssertFalse($0.containsOnlyEmojiWithSpaces, "\($0) has emojis")
            XCTAssertFalse($0.containsEmoji, "\($0) contains emojis")
        }
    }

    func testThatLangaugeStringIsNotDetected() {
        // given

        //Notice: "⿆" - Kangxi Radicals, start from U0x2F0x it is not a emoji, but CharacterSet.symbols contains it.
        let langaugeStrings = ["ḀẀẶỳ", "ठःअठी३", "勺卉善爨", "Ёжик", "한국어",
                               "ⰀⰁ", //Glagolitic, start from U0x2C0x, containsEmoji return true for this language
            "はい",// Hiragana, start from U0x304x
            "ブ",// Katakana, start from U0x304x
            "ㄅㄆㄇ", //Bopomofo, start from U0x310x
            "Ⴀჟჯჰ", // Georgian, updated in uncodie 11.0
            "ქართული", // Georgian, updated in uncodie 11.0
            " Α α, Β β, Γ γ, Δ δ, Ε ε, Ζ ζ, Η η, Θ θ, Ι ι, Κ κ, Λ λ, Μ μ, Ν ν, Ξ ξ, Ο ο, Π π, Ρ ρ, Σ σ/ς, Τ τ, Υ υ, Φ φ, Χ χ, Ψ ψ, Ω ω.", //Greek
            "。，？！" // Chinese punctuation marks
        ]
        // then
        langaugeStrings.forEach {
            XCTAssertFalse($0.containsOnlyEmojiWithSpaces, "\($0) has emojis")
            XCTAssertFalse($0.containsEmoji, "\($0) contains emojis")
        }
    }
    
    func testThatRTLStringIsNotDetected() {
        // given
        let rtlStrings = ["  באמת!‏"]
        // then
        rtlStrings.forEach {
            XCTAssertFalse($0.containsOnlyEmojiWithSpaces)
        }
    }
    
    func testThatLanguageStringWithEmojiNotDetected() {
        // given
        let languageEmojiStrings = ["😜ḀẀẶỳ", "👯ठःअठी३", "👯勺卉善爨", "👯Ёжик"]
        // then
        languageEmojiStrings.forEach {
            XCTAssertFalse($0.containsOnlyEmojiWithSpaces, "Failed: \($0)")
            XCTAssert($0.containsEmoji)
        }
    }
    
    func testThatEmptyStringIsNotDetected() {
        XCTAssertFalse("".containsOnlyEmojiWithSpaces)
    }
}
