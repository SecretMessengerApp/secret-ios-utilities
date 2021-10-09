// 
// 


@import XCTest;
@import OCMock;

#import "NSUserDefaults+SharedUserDefaults.h"

@interface NSUserDefaults_SharedUserDefaultsTests : XCTestCase

@end

@implementation NSUserDefaults_SharedUserDefaultsTests

static NSString *const cookiesKey = @"ZMCookieKey";

- (void)tearDown {
    [[NSUserDefaults sharedUserDefaults] removeObjectForKey:cookiesKey];
    [super tearDown];
}

- (void)testThatItReturnsNilFromGroupNameIfNoWireGroupIdInInfoPlist
{
#if !TARGET_OS_IPHONE
    XCTAssertNil([NSUserDefaults groupName]);
#else
    NSMutableDictionary *infoPlist = [[[NSBundle mainBundle] infoDictionary] mutableCopy];
    [infoPlist removeObjectForKey:@"WireGroupId"];
    id mockBundle = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[mockBundle stub] andReturn:infoPlist] infoDictionary];
    XCTAssertNil([NSUserDefaults groupName]);
    [mockBundle stopMocking];
#endif
}

- (void)testThatItReturnsExpectedGroupName
{
#if TARGET_OS_IPHONE
    NSMutableDictionary *infoPlist = [[[NSBundle mainBundle] infoDictionary] mutableCopy];
    infoPlist[@"WireGroupId"] = @"test.bundle.id";
    id mockBundle = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[mockBundle stub] andReturn:infoPlist] infoDictionary];
    XCTAssertEqualObjects([NSUserDefaults groupName], @"group.test.bundle.id");
    [mockBundle stopMocking];
#endif
}

- (void)testThatItReturnsExpectedUserDefaults
{
#if TARGET_OS_IPHONE
    NSMutableDictionary *infoPlist = [[[NSBundle mainBundle] infoDictionary] mutableCopy];
    infoPlist[@"WireGroupId"] = @"com.wearezeta.zclient-alpha";
    id mockBundle = [OCMockObject partialMockForObject:[NSBundle mainBundle]];
    [[[mockBundle stub] andReturn:infoPlist] infoDictionary];

#endif
    
    //given
    NSUserDefaults *defaults = [NSUserDefaults sharedUserDefaults];
    NSString *groupName = [NSUserDefaults groupName];
    NSUserDefaults *testDefaults = [[NSUserDefaults alloc] initWithSuiteName:groupName];

    //when
    NSString *expectedValue = @"value";
    [testDefaults setObject:expectedValue forKey:@"test"];
    [testDefaults synchronize];

    //then
    NSString *value = [defaults valueForKey:@"test"];
    XCTAssertEqualObjects(value, expectedValue);
   
#if TARGET_OS_IPHONE
    [mockBundle stopMocking];
#endif
}

- (void)testThatItReturnsTheSameCookiesKey
{
    //given
    NSData *key1 = [NSUserDefaults cookiesKey];
    
    //when
    NSData *key2 = [NSUserDefaults cookiesKey];
    
    //then
    XCTAssertEqualObjects(key2, key1);
}

- (void)testThatItCreatesNewKeyIfNoKeyFoundInDefaults
{
    //given
    NSData *key1 = [NSUserDefaults cookiesKey];
    [[NSUserDefaults sharedUserDefaults] removeObjectForKey:cookiesKey];
    
    //when
    NSData *key2 = [NSUserDefaults cookiesKey];
    
    //then
    XCTAssertNotEqualObjects(key1, key2);
}

#if TARGET_OS_IPHONE
//this is only for iOS, on OSX we still use standard user defaults
- (void)testThatItMovesCookiesFromStandardDefaultsToSharedDefaults
{
    //given
    NSData *key1 = [NSUserDefaults cookiesKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:key1 forKey:cookiesKey];
    [[NSUserDefaults sharedUserDefaults] removeObjectForKey:cookiesKey];
    
    //when
    NSData *key2 = [NSUserDefaults cookiesKey];
    XCTAssertEqualObjects(key2, key1);
    
    //then
    
    //key should be removed from standard user defaults
    XCTAssertNil([[NSUserDefaults standardUserDefaults] objectForKey:cookiesKey]);
    
    //key should be stored in shared user defaults
    XCTAssertEqualObjects([[NSUserDefaults sharedUserDefaults] objectForKey:cookiesKey], key1);
}
#endif


@end
