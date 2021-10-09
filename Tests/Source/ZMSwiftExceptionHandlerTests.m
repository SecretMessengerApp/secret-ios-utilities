// 
// 


@import WireTesting;
@import WireUtilities;

@interface ZMSwiftExceptionHandlerTests : ZMTBaseTest
@end



@implementation ZMSwiftExceptionHandlerTests

- (void)testThatItExecutesTheBlock
{
    // when
    NSException *exception = zm_tryBlock(^{
        [NSException raise:@"Exception" format:@"This is the expected exception"];
    });
    
    // then
    XCTAssertNotNil(exception);
}

- (void)testThatItReturnsNilForNonThrowingBlock
{
    // given
    __block NSUInteger callCount = 0;
    
    // when
    NSException *exception = zm_tryBlock(^{
        callCount++;
    });
    
    // then
    XCTAssertNil(exception);
    XCTAssertEqual(callCount, 1u);
}

@end
