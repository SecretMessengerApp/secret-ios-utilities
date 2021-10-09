// 
// 


@import Foundation;
@import WireSystem;
@import WireTesting;

#import "NSData+ZMAdditions.h"
#import <XCTest/XCTest.h>

@interface NSData_ZMAdditionsTests : XCTestCase

@end

@implementation NSData_ZMAdditionsTests


- (void)testThatTheSameNSDataComparesEqual {
    // given
    NSData *data = [@"ciao" dataUsingEncoding:NSUTF8StringEncoding];
    
    // when
    NSComparisonResult result = [data compare:data];
    
    // then
    XCTAssertEqual(result, NSOrderedSame);
}

- (void)testThatAnEquivalentNSDataComparesEqual {
    // given
    NSData *data1 = [@"ciao" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"ciao" dataUsingEncoding:NSUTF8StringEncoding];
    
    // when
    NSComparisonResult result = [data1 compare:data2];
    
    // then
    XCTAssertEqual(result, NSOrderedSame);
}

- (void)testThatAGreaterNSDataComparesGreater {
    // given
    NSData *data1 = [@"99" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"11" dataUsingEncoding:NSUTF8StringEncoding];
    
    // when
    NSComparisonResult result = [data1 compare:data2];
    
    // then
    XCTAssertEqual(result, NSOrderedDescending);
}

- (void)testThatALesserNSDataComparesLesser {
    // given
    NSData *data1 = [@"22" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"44" dataUsingEncoding:NSUTF8StringEncoding];
    
    // when
    NSComparisonResult result = [data1 compare:data2];
    
    // then
    XCTAssertEqual(result, NSOrderedAscending);
}

- (void)testThatAnNSDataASubstringOfAnotherComparesLesser {
    // given
    NSData *data1 = [@"22" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2 = [@"2222" dataUsingEncoding:NSUTF8StringEncoding];
    
    // when
    NSComparisonResult result = [data1 compare:data2];
    
    // then
    XCTAssertEqual(result, NSOrderedAscending);
}

-(void)testThatNSDataDispatchDataEqualsString
{
    // given
    NSString *input = @"hello foobar";
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    // when
    dispatch_data_t dispatchData = data.dispatchData;
    
    // then
    const void* buffer;
    size_t size;
    dispatch_data_t mappedData = dispatch_data_create_map(dispatchData, &buffer, &size);
    NOT_USED(mappedData);
    
    NSString *output = [[NSString alloc] initWithBytes:buffer length:size encoding:NSUTF8StringEncoding];
    XCTAssertEqualObjects(input, output);
}

@end
