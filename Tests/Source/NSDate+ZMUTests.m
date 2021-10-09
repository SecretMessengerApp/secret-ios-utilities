// 
// 


#import <XCTest/XCTest.h>
#import "NSDate+Utility.h"


@interface NSDate_UtilityTests : XCTestCase

@end



@implementation NSDate_UtilityTests

- (void)testThatItReturnsTheEarlierDate
{
    // given
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceReferenceDate:1000000];
    NSDate *date2 = [NSDate dateWithTimeInterval:1000 sinceDate:date1];
    NSDate *date3 = [NSDate dateWithTimeInterval:-1000 sinceDate:date1];
    
    // then
    XCTAssertEqualWithAccuracy([NSDate earliestOfDate:date1 and:date2].timeIntervalSinceReferenceDate, date1.timeIntervalSinceReferenceDate, 0.1);
    XCTAssertEqualWithAccuracy([NSDate earliestOfDate:date1 and:date3].timeIntervalSinceReferenceDate, date3.timeIntervalSinceReferenceDate, 0.1);
}

- (void)testThatItReturnsTheLatestDate
{
    // given
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceReferenceDate:1000000];
    NSDate *date2 = [NSDate dateWithTimeInterval:1000 sinceDate:date1];
    NSDate *date3 = [NSDate dateWithTimeInterval:-1000 sinceDate:date1];
    
    // then
    XCTAssertEqualWithAccuracy([NSDate lastestOfDate:date1 and:date2].timeIntervalSinceReferenceDate, date2.timeIntervalSinceReferenceDate, 0.1);
    XCTAssertEqualWithAccuracy([NSDate lastestOfDate:date1 and:date3].timeIntervalSinceReferenceDate, date1.timeIntervalSinceReferenceDate, 0.1);
}

- (void)testThatItReturnsTheNonNullDate
{
    // given
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:100];
    
    // then
    XCTAssertEqualObjects([NSDate earliestOfDate:nil and:date], date);
    XCTAssertEqualObjects([NSDate earliestOfDate:date and:nil], date);
    XCTAssertEqualObjects([NSDate lastestOfDate:nil and:date], date);
    XCTAssertEqualObjects([NSDate lastestOfDate:date and:nil], date);
}

@end
