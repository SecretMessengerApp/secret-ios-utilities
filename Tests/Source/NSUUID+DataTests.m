// 
// 


#import <XCTest/XCTest.h>
@import WireUtilities;
@import WireTesting;

@interface NSUUIDDataTests : XCTestCase

@end

@implementation NSUUIDDataTests

- (void)testThatDataCreateFromUUIDIsNotEmpty;
{
    NSUUID *UUID = [NSUUID UUID];
    NSData *data = [UUID data];
   
    XCTAssertNotNil(data);
    XCTAssertNotEqual([data length], 0lu);
}

- (void)testThatDataCreateFromUUIDContainsCorrectData;
{
    const uuid_t UUIDBytes = "0123456789abcdef";
    
    NSUUID *UUID = [[NSUUID alloc] initWithUUIDBytes:UUIDBytes];
    NSData *data = [UUID data];
   
    int comparasionResult = memcmp([data bytes], UUIDBytes, sizeof(UUIDBytes));
    XCTAssertEqual(comparasionResult, 0);
}

@end
