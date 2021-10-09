//
//


@import XCTest;

#import <WireUtilities/WireUtilities.h>
#import <WireUtilities/WireUtilities-Swift.h>

@interface ZMPhoneNumberValidatorTests : XCTestCase

@end

@implementation ZMPhoneNumberValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatValidNumbersPassValidation
{
    NSArray *validPhoneNumbers =
    @[@"123456789012345678", // normal length
      @"+4915233336668",
      @"+49 152 3333 6668",
      @"+49 (0) 152 3333 6668",
      @"(152) 3333-6668",
      @"415.456.456",
      @"+1 415.456.456",
      @"00 1 415.456.456",
      @""];
    
    BOOL isValid;
    BOOL isValidWithNonMutableCheck;
    NSError *error;
    for (NSString *phoneNumber in validPhoneNumbers) {
        NSString *value = phoneNumber;
        isValid = [ZMPhoneNumberValidator validateValue:&value error:&error];
        isValidWithNonMutableCheck = [ZMPhoneNumberValidator isValidPhoneNumber:value];
        XCTAssertTrue(value);
        XCTAssertTrue(isValidWithNonMutableCheck);
        XCTAssertNil(error);
    }
}

- (void)testThatInvalidNumbersDoNotPassValidation
{
    NSArray *invalidPhoneNumbers =
    @[@"1234@1234", // Invalid character
      @"1234a1234", // Invalid character
      @"1234%1234", // Invalid character
      @"1234^1234", // Invalid character
      ];
    
    BOOL isValid;
    BOOL isValidWithNonMutableCheck;
    NSError *error;
    for (NSString *phoneNumber in invalidPhoneNumbers) {
        NSString *value = phoneNumber;
        isValid = [ZMPhoneNumberValidator validateValue:&value error:&error];
        isValidWithNonMutableCheck = [ZMPhoneNumberValidator isValidPhoneNumber:value];
        XCTAssertFalse(isValid);
        XCTAssertFalse(isValidWithNonMutableCheck);
        XCTAssertNotNil(error);
    }
}

- (void)testThatItRemovesAllNonNumericCharacters
{
    // given
    NSArray *numbers = @[
                         @"+49123(45)678",
                         @" + 4 9 1 2 3 4 5 6 7 8",
                         @"(+49)123-456-78",
                         @"+49.123.456.78"
                         ];
    NSString *expectedNumber = @"+4912345678";
    
    // when
    for(NSString *numberToTest in numbers) {
        NSString *ioNumber = [numberToTest copy];
        XCTAssertTrue([ZMPhoneNumberValidator validateValue:&ioNumber error:nil]);
        XCTAssertEqualObjects(ioNumber, expectedNumber, @"%@ was not normalized to %@ (was %@ instead)", numberToTest, expectedNumber, ioNumber);
    }
}

@end
