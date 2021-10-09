// 
// 


#import <XCTest/XCTest.h>
#import "NSOperationQueue+Helpers.h"

@interface NSOperationQueueHelpersTests : XCTestCase

@end

@implementation NSOperationQueueHelpersTests

- (void)testThatSerialQueueFactoryReturnsAQueueWithOneCurrencurentOperationQueue;
{
    NSOperationQueue *serialQueue = [NSOperationQueue zm_serialQueueWithName:@"ASerialQueue"];
    XCTAssertEqual(serialQueue.maxConcurrentOperationCount, 1);
}

- (void)testThatSerialQueueFactoryReturnsAQueueWithCorrectName;
{
    NSString *queueName = @"ASerialQueue";
    NSOperationQueue *serialQueue = [NSOperationQueue zm_serialQueueWithName:queueName];
    XCTAssertEqualObjects(serialQueue.name, queueName);
}


@end
