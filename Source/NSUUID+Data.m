// 
// 


#import "NSUUID+Data.h"

@implementation NSUUID (Data)

- (NSData *)data {
    uuid_t uuidBytes;
    [self getUUIDBytes:uuidBytes];
    return [NSData dataWithBytes:uuidBytes length:sizeof(uuidBytes)];
}

@end
