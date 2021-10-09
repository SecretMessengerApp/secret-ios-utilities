// 
// 


#import <XCTest/XCTest.h>
#import "NSURL+QueryComponents.h"


@interface NSURLQueryComponentsTest : XCTestCase

@end

@implementation NSURLQueryComponentsTest

- (void)testThatItParsesAllQueryComponents
{
    // given
    NSURL *url = [NSURL URLWithString:@"https://www.wire.com/path/some?foo=bar&gg=1&ff=&data=213-324"];
    NSDictionary *expected = @{
                               @"foo" : @"bar",
                               @"gg" : @"1",
                               @"data" : @"213-324",
                               @"ff" : @""
                               };
    
    
    // when
    NSDictionary *components = url.zm_queryComponents;
    
    // then
    XCTAssertEqualObjects(components, expected);
}

- (void)testThatItDoesNotParsesQueryComponentsOnMalformedURL_1
{
    // given
    NSURL *url = [NSURL URLWithString:@"https://www.wire.com/path/some?zuid=bar=baz"];
    
    // when
    NSDictionary *components = url.zm_queryComponents;
    
    // then
    XCTAssertEqual(components.count, 0u);
}

- (void)testThatItDoesNotParsesQueryComponentsOnMalformedURL_2
{
    // given
    NSURL *url = [NSURL URLWithString:@"https://www.wire.com/path/some?zuid=bar?baz=22"];
    
    // when
    NSDictionary *components = url.zm_queryComponents;
    
    // then
    XCTAssertEqual(components.count, 0u);
}

@end
