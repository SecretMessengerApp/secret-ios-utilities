//
//

import XCTest

class StringLengthValidatorTests: XCTestCase {
    func testThatUnicode5EmojiContainsTagsPassesValidation() {
        let originalValue = "🏴󠁧󠁢󠁷󠁬󠁳󠁿"
        var value: AnyObject? = originalValue as AnyObject?
        var error: Error?

        do {
            try StringLengthValidator.validateValue(&value, minimumStringLength: 1, maximumStringLength: 64, maximumByteLength: 100)
        }
        catch let err {
            error = err
        }

        XCTAssertNil(error)
        XCTAssertEqual(originalValue, value! as! String)
    }
    
    func testThatTooShortStringsDoNotPassValidation() {
        var value: AnyObject? = "short" as AnyObject
        do {
            try StringLengthValidator.validateValue(&value,
                                                             minimumStringLength: 15,
                                                             maximumStringLength: 100,
                                                             maximumByteLength: 100)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testThatTooLongStringsDoNotPassValidation() {
        var value: AnyObject? = "long" as AnyObject
        do {
            try StringLengthValidator.validateValue(&value,
                                                    minimumStringLength: 1,
                                                    maximumStringLength: 3,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testThatValidStringsPassValidation() {
        var value: AnyObject? = "normal" as AnyObject
        do {
            try StringLengthValidator.validateValue(&value,
                                                    minimumStringLength: 1,
                                                    maximumStringLength: 10,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNil(error)
        }
        //XCTAssertTrue REsult
    }
    
    func testThatCombinedEmojiPassesValidation_3() {
        let originalValue: AnyObject? = "👨‍👧‍👦" as AnyObject
        var value = originalValue
        
        do {
            try StringLengthValidator.validateValue(&value,
                                                    minimumStringLength: 1,
                                                    maximumStringLength: 64,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNil(error)
        }
        //XCTAssertTrue REsult
        XCTAssertEqual(originalValue as! String, value as! String)
    }
    
    func testThatCombinedEmojiPassesValidation_4() {
        let originalValue: AnyObject? = "👩‍👩‍👦‍👦" as AnyObject
        var value = originalValue
        
        do {
            try StringLengthValidator.validateValue(&value,
                                                    minimumStringLength: 1,
                                                    maximumStringLength: 64,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNil(error)
        }
        //XCTAssertTrue REsult
        XCTAssertEqual(originalValue as! String, value as! String)
    }
    
    func testThatItRemovesControlCharactersBetweenCombinedEmoji() {
        let originalValue: AnyObject? = "👩‍👩‍👦‍👦/n👨‍👧‍👦" as AnyObject
        var value = originalValue
        
        do {
            try StringLengthValidator.validateValue(&value,
                                                    minimumStringLength: 1,
                                                    maximumStringLength: 64,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNil(error)
        }
        //XCTAssertTrue REsult
        XCTAssertEqual(originalValue as! String, value as! String)
    }
    
    func testThatNilIsNotValid() {
        
        var value: AnyObject? = nil
        
        do {
            try StringLengthValidator.validateValue(&value,
                                                    minimumStringLength: 1,
                                                    maximumStringLength: 10,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNotNil(error)
        }
        //XCTAssertFalse REsult
    }
    
    func testThatItReplacesNewlinesAndTabWithSpacesInThePhoneNumber() {
        
        var phoneNumber: AnyObject? = "1234\n5678" as AnyObject
        
        do {
            try StringLengthValidator.validateValue(&phoneNumber,
                                                    minimumStringLength: 0,
                                                    maximumStringLength: 20,
                                                    maximumByteLength: 100)
        } catch {
            XCTAssertNil(error)
        }
        XCTAssertEqual(phoneNumber as! String, "1234 5678")
    }
    
}
