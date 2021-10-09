// 
// 


#import "NSDate+Utility.h"

@implementation NSDate (Utility)

+ (NSDate *)earliestOfDate:(NSDate *)date1 and:(NSDate *)date2;
{
    if (date1 == nil) {
        return date2;
    }
    if (date2 == nil) {
        return date1;
    }
    return [date1 earlierDate:date2];
}

+ (NSDate *)lastestOfDate:(NSDate *)date1 and:(NSDate *)date2;
{
    if (date1 == nil) {
        return date2;
    }
    if (date2 == nil) {
        return date1;
    }
    return [date1 laterDate:date2];
}

@end
