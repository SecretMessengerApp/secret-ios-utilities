//
//


@import XCTest;

#import <WireUtilities/WireUtilities.h>
#import <WireUtilities/WireUtilities-Swift.h>

@interface ZMAccentColorValidatorTests : XCTestCase

@end

@implementation ZMAccentColorValidatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItLimitsTheAccentColorToAValidRange;
{
    // given
    id value = [NSNumber numberWithInt:ZMAccentColorBrightYellow];
    //when
    [ZMAccentColorValidator validateValue:&value error:NULL];
    //then
    XCTAssertEqual([value intValue], ZMAccentColorBrightYellow);
    
    //given
    value = [NSNumber numberWithInt:ZMAccentColorUndefined];
    // when
    [ZMAccentColorValidator validateValue:&value error:NULL];
    // then
    XCTAssertGreaterThanOrEqual([value intValue], ZMAccentColorMin);
    XCTAssertLessThanOrEqual([value intValue], ZMAccentColorMax);
    
    //give
    value = [NSNumber numberWithInt:(ZMAccentColor) (ZMAccentColorMax + 1)];
    // when
    [ZMAccentColorValidator validateValue:&value error:NULL];
    
    // then
    XCTAssertGreaterThanOrEqual([value intValue], ZMAccentColorMin);
    XCTAssertLessThanOrEqual([value intValue], ZMAccentColorMax);
}

@end
