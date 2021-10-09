// 
// 


#import <Foundation/Foundation.h>


@interface NSDate (Utility)

+ (NSDate *)earliestOfDate:(NSDate *)date1 and:(NSDate *)date2;
+ (NSDate *)lastestOfDate:(NSDate *)date1 and:(NSDate *)date2;

@end
