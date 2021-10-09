// 
// 


#import <XCTest/XCTest.h>
#import "NSString+Normalization.h"

@interface NSString_NormalizationTests : XCTestCase

@end

@implementation NSString_NormalizationTests


- (void)testThatItConvertsToLowercase
{
    NSString *normalizedString = [@"SomEThIng" normalizedString];
    
    XCTAssertEqualObjects(normalizedString, @"something");
}


- (void)testThatItRemovesDiacritics
{
    NSString *normalizedString = [@"sömëthîñg" normalizedString];
    XCTAssertEqualObjects(normalizedString, @"something");
    
    NSString *normalizedString2 = [@"Håkon Bø" normalizedString];
    XCTAssertEqualObjects(normalizedString2, @"hakon bo");

}


- (void)testThatItConvertsToLatin
{
    NSString *normalizedString = [@"שלום" normalizedString];
    XCTAssertEqualObjects(normalizedString, @"slwm");

    NSString *normalizedString2 = [@"안녕하세요" normalizedString];
    XCTAssertEqualObjects(normalizedString2, @"annyeonghaseyo");

    NSString *normalizedString3 = [@"ひらがな" normalizedString];
    XCTAssertEqualObjects(normalizedString3, @"hiragana");
}

- (void)testThatItRemovesNonAlphaNumericCharacters
{
    NSString *normalizedString = [@"😍hey😍hey😍hey😍hey😍hey😍hey😍hey😍" normalizedString];
    XCTAssertEqualObjects(normalizedString, @"heyheyheyheyheyheyhey");
    
    NSString *normalizedString2 = [@"#hey" normalizedString];
    XCTAssertEqualObjects(normalizedString2, @"hey");
    
    NSString *normalizedString3 = [@"@hey" normalizedString];
    XCTAssertEqualObjects(normalizedString3, @"hey");
    
    NSString *normalizedString4 = [@"(hey)" normalizedString];
    XCTAssertEqualObjects(normalizedString4, @"hey");
    
    NSString *normalizedString5 = [@"😍😍" normalizedString];
    XCTAssertEqualObjects(normalizedString5, @"");
    
    NSString *normalizedString6 = [@"😍😍hey" normalizedString];
    XCTAssertEqualObjects(normalizedString6, @"hey");

}

- (void)testThatItDoesNotRemoveWhiteSpaceCharacters
{
    NSString *normalizedString = [@"hey you" normalizedString];
    XCTAssertEqualObjects(normalizedString, @"hey you");
}

- (void)testThatItDoesNotRemoveSpecialCharactersInEmailaddresses
{
    NSString *normalizedEmailaddress = [@"hallo-du@example.com" normalizedEmailaddress];
    XCTAssertEqualObjects(normalizedEmailaddress, @"hallo-du@example.com");
}

- (void)testThatItConvertsToLowercase_ForSearch
{
    NSString *normalizedString = [@"SomEThIng" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString, @"something");
}

- (void)testThatItRemovesDiacritics_ForSearch
{
    NSString *normalizedString = [@"sömëthîñg" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString, @"something");

    NSString *normalizedString2 = [@"Håkon Bø" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString2, @"hakon bø"); // U+00F8 is it's own Unicode character
}

- (void)testThatItConvertsToLatin_ForSearch
{
    NSString *normalizedString = [@"שלום" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString, @"שלום");

    NSString *normalizedString2 = [@"안녕하세요" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString2, @"안녕하세요");

    NSString *normalizedString3 = [@"ひらがな" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString3, @"ひらがな");
}

- (void)testThatItDoesNotRemoveEmoji_ForSearch
{
    NSString *normalizedString = [@"😍hey😍hey😍hey😍hey😍hey😍hey😍hey😍" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString, @"😍hey😍hey😍hey😍hey😍hey😍hey😍hey😍");

    NSString *normalizedString5 = [@"😍😍" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString5, @"😍😍");

    NSString *normalizedString6 = [@"😍😍hey" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString6, @"😍😍hey");
}

- (void)testThatItDoesNotRemoveWhiteSpaceCharacters_ForSearch
{
    NSString *normalizedString = [@"hey you" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString, @"hey you");
}

- (void)testThatItRemovesPunctuationCharacters_ForSearch
{
    NSString *normalizedEmailaddress = [@"hello. world? worlds!..." normalizedForSearch];
    XCTAssertEqualObjects(normalizedEmailaddress, @"hello world worlds");

    NSString *normalizedString2 = [@"#hey" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString2, @"hey");

    NSString *normalizedString3 = [@"@hey" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString3, @"hey");

    NSString *normalizedString4 = [@"(hey)" normalizedForSearch];
    XCTAssertEqualObjects(normalizedString4, @"hey");
}

- (void)testThatItDoesNotRemovePunctuationCharacters_ForMentionSearch
{
    NSString *normalizedEmailaddress = [@"hêlló. wörld? wõrlds!..." normalizedForMentionSearch];
    XCTAssertEqualObjects(normalizedEmailaddress, @"hello. world? worlds!...");
    
    NSString *normalizedString2 = [@"#hëy" normalizedForMentionSearch];
    XCTAssertEqualObjects(normalizedString2, @"#hey");
    
    NSString *normalizedString3 = [@"@hēy" normalizedForMentionSearch];
    XCTAssertEqualObjects(normalizedString3, @"@hey");
    
    NSString *normalizedString4 = [@"(hęy)" normalizedForMentionSearch];
    XCTAssertEqualObjects(normalizedString4, @"(hey)");
}


@end
