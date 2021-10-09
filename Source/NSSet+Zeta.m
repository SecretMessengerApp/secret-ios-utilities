// 
// 


#import "NSSet+Zeta.h"



@implementation NSSet (Zeta)

+ (instancetype)zmSetByCompiningSets:(NSSet * const [])sets count:(NSUInteger)cnt;
{
    if (cnt == 0) {
        return [self set];
    } else if (cnt == 1) {
        return sets[0];
    }
    NSMutableSet *result = [NSMutableSet set];
    for (NSUInteger i = 0; i < cnt; ++i) {
        [result unionSet:sets[i]];
    }
    return result;
}

+ (instancetype)zmSetByCompiningSets:(NSSet *)firstSet, ...;
{
    
    NSMutableSet *result = [NSMutableSet setWithSet:firstSet];
    if (firstSet != nil) {
        va_list ap;
        va_start(ap, firstSet);
        while (YES) {
            NSSet *set = va_arg(ap, NSSet *);
            if (set == nil) {
                break;
            }
            [result unionSet:set];
        }
        va_end(ap);
    }
    return result;
}

@end
