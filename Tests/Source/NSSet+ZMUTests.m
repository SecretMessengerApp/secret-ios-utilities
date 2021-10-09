// 
// 


#import <XCTest/XCTest.h>
#import "NSSet+Zeta.h"



@interface NSSetAdditionsTests : XCTestCase
@end



@implementation NSSetAdditionsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCombinesSets_1
{
    // given
    NSSet *a = [NSSet setWithObjects:@"A", @"B", nil];
    NSSet *b = [NSSet setWithObjects:@"C", @"D", nil];
    
    // when
    NSSet *result = [NSSet zmSetByCompiningSets:a, b, nil];
    
    // then
    NSSet *expected = [NSSet setWithObjects:@"A", @"B", @"C", @"D", nil];
    XCTAssertEqualObjects(result, expected);
}

- (void)testThatItCombinesSets_2
{
    // given
    NSSet *a = [NSSet setWithObjects:@"A", @"B", nil];
    NSSet *b = [NSSet setWithObjects:@"C", @"D", nil];
    
    // when
    NSSet *result = [NSSet zmSetByCompiningSets:(NSSet * const []){a, b} count:2];
    
    // then
    NSSet *expected = [NSSet setWithObjects:@"A", @"B", @"C", @"D", nil];
    XCTAssertEqualObjects(result, expected);
}

- (void)testThatItReturnsAnEmptySetWhenCombiningNothing_1
{
    // when
    NSSet *result = [NSSet zmSetByCompiningSets:nil];
    
    // then
    XCTAssertEqualObjects(result, [NSSet set]);
}

- (void)testThatItReturnsAnEmptySetWhenCombiningNothing_2
{
    // when
    NSSet *result = [NSSet zmSetByCompiningSets:(NSSet * const []){} count:0];
    
    // then
    XCTAssertEqualObjects(result, [NSSet set]);
}

@end
