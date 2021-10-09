// 
// 


#import <XCTest/XCTest.h>
@import WireTesting;

#import "ZMEncodedNSUUIDWithTimestamp.h"
#import <CommonCrypto/CommonCrypto.h>

static unsigned long SampleTimestamp = 1398634400; // Sun, 27 Apr 2014 21:33:20 GMT
static unsigned long HOUR_IN_SEC = 60 * 60;

@interface ZMEncodedNSUUIDWithTimestampTests : XCTestCase

@end



@implementation ZMEncodedNSUUIDWithTimestampTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSData *)randomKey
{
    uint8_t random[kCCKeySizeAES256];
    int success = SecRandomCopyBytes(kSecRandomDefault, kCCKeySizeAES256, random);
    XCTAssert(success == errSecSuccess);
    return [NSData dataWithBytes:random length:kCCKeySizeAES256];
}

- (void)testThatItInitsFromPlainData
{
    // given
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:SampleTimestamp];
    NSUUID *uuid = [NSUUID createUUID];
    
    // when
    ZMEncodedNSUUIDWithTimestamp *sut = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:[self randomKey]];
    
    // then
    XCTAssertEqualObjects(sut.timestampDate, timestamp);
    XCTAssertEqualObjects(sut.uuid, uuid);
}

- (void)testThatItCreatesA32BitEncodedRepresentation
{
    // given
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:SampleTimestamp];
    NSUUID *uuid = [NSUUID createUUID];

    // when
    ZMEncodedNSUUIDWithTimestamp *sut = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:[self randomKey]];
    
    // then
    XCTAssertEqual(sut.encodedData.length, 32u);
}

- (void)testThatEncodedRepresentationsAreDifferentIfTheKeyIsDifferent
{
    // given
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:SampleTimestamp];
    NSUUID *uuid = [NSUUID createUUID];
    
    // when
    ZMEncodedNSUUIDWithTimestamp *sut1 = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:[self randomKey]];
    ZMEncodedNSUUIDWithTimestamp *sut2 = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:[self randomKey]];
    
    // then
    XCTAssertNotEqualObjects(sut1.encodedData, sut2.encodedData);
}


- (void)testThatEncodedRepresentationsWithSameKeyAndSameDataAreDifferent
{
    // given
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:SampleTimestamp];
    NSUUID *uuid = [NSUUID createUUID];
    NSData *encryptionKey = [self randomKey];
    
    // when
    ZMEncodedNSUUIDWithTimestamp *sut1 = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:encryptionKey];
    ZMEncodedNSUUIDWithTimestamp *sut2 = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:encryptionKey];
    
    // then
    XCTAssertNotEqualObjects(sut1.encodedData, sut2.encodedData);
}

+ (NSDate *)dateByStrippingMinutesFromDate:(NSDate *)date
{
    return [NSDate dateWithTimeIntervalSince1970:date.timeIntervalSince1970 - (unsigned long) date.timeIntervalSince1970 % HOUR_IN_SEC];
}

- (void)testThatItDecryptsDataCorrectly
{
    // given
    NSDate *timestamp = [NSDate dateWithTimeIntervalSince1970:SampleTimestamp];
    NSDate *finalTimestamp = [self.class dateByStrippingMinutesFromDate:timestamp];
    NSUUID *uuid = [NSUUID createUUID];
    NSData *encryptionKey = [self randomKey];
    
    // when
    ZMEncodedNSUUIDWithTimestamp *sut1 = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithUUID:uuid timestampDate:timestamp encryptionKey:encryptionKey];
    
    ZMEncodedNSUUIDWithTimestamp *sut2 = [[ZMEncodedNSUUIDWithTimestamp alloc] initWithEncodedData:sut1.encodedData encryptionKey:encryptionKey];
    
    // then
    XCTAssertEqualObjects(sut1.encodedData, sut2.encodedData);
    XCTAssertEqualObjects(sut2.uuid, uuid);
    XCTAssertEqualObjects(sut2.timestampDate, finalTimestamp);
}

@end





