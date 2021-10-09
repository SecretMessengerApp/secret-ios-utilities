// 
// 


@import WireSystem;

#import "NSUserDefaults+SharedUserDefaults.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSUserDefaults (SharedUserDefaults)

+ (NSString *)groupName
{
#if TARGET_OS_IPHONE
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    if (infoDict[@"WireGroupId"] != nil) {
        NSString *groupName = [NSString stringWithFormat:@"group.%@", infoDict[@"WireGroupId"]];
        return groupName;
    }
#endif
    return nil;
}

+ (instancetype)sharedUserDefaults
{
    return [[NSUserDefaults alloc] initWithSuiteName:[self groupName]];
}

+ (NSData *)cookiesKey
{
    static NSString * const CookieKeyKey = @"ZMCookieKey";
    NSUserDefaults *sharedDefaults = [NSUserDefaults sharedUserDefaults];
    NSData *key = [sharedDefaults dataForKey:CookieKeyKey];
    if (key == nil) {
        
#if TARGET_OS_IPHONE
        //On older versions we stored key in standard user defaults.
        //We need to check for key there first and save it to shared defaults.
        //This way extension can use it to decrypt cookies stored in keychain
        key = [[NSUserDefaults standardUserDefaults] dataForKey:CookieKeyKey];
        if (key != nil) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:CookieKeyKey];
        }
        else {
#endif
            //create new key
        NSMutableData *newKey = [NSMutableData dataWithLength:kCCKeySizeAES256];
        int success = SecRandomCopyBytes(kSecRandomDefault, newKey.length, (uint8_t *) newKey.mutableBytes);
        Require(success == errSecSuccess);
        key = newKey;
        
#if TARGET_OS_IPHONE
        }
#endif
        
        [sharedDefaults setObject:key forKey:CookieKeyKey];
    }
    return key;
}

@end
