// 
// 


#import <Foundation/Foundation.h>

@interface ZMEncodedNSUUIDWithTimestamp : NSObject

@property (nonatomic, readonly) NSUUID *uuid;
@property (nonatomic, readonly) NSDate *timestampDate;
@property (nonatomic, readonly) NSData *encodedData;

- (instancetype)initWithEncodedData:(NSData *)data encryptionKey:(NSData *)encryptionKey;
- (instancetype)initWithUUID:(NSUUID *)UUID timestampDate:(NSDate *)timestampDate encryptionKey:(NSData *)encryptionKey;
- (instancetype)initWithSafeBase64EncodedToken:(NSString *)token withEncryptionKey:(NSData *)encryptionKey;

- (NSURL *)URLWithEncodedUUIDWithTimestampPrefixedWithString:(NSString *)prefix;

@end
