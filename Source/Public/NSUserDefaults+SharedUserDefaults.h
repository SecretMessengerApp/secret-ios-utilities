// 
// 


#import <Foundation/Foundation.h>



@interface NSUserDefaults (SharedUserDefaults)

+ (NSString *)groupName;
+ (instancetype)sharedUserDefaults;
+ (NSData *)cookiesKey;

@end
