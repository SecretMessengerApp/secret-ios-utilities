// 
// 


#import "ZMFunctional.h"

#if __has_feature(objc_arc)
#error This file cannot be compiled with ARC. Add -fno-objc-arc as a compiler flag
#endif


@implementation NSArray (ZMFunctional_withoutARC)

- (NSArray *)mapWithSelector:(SEL)selector;
{
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self) {
        @autoreleasepool {
            id newObj = [obj performSelector:selector];
            if (newObj != nil) {
                [result addObject:newObj];
            }
        }
    }
    return result;
}

- (id)firstNonNilReturnedFromSelector:(SEL)selector;
{
    for(id obj in self) {
        if(obj && obj != [NSNull null]) {
            id result = [obj performSelector:selector];
            if(result != nil) {
                return result;
            }
        }
    }
    return nil;
}

@end



@implementation NSOrderedSet (ZMFunctional_withoutARC)

- (NSOrderedSet *)mapWithSelector:(SEL)selector;
{
    NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSet];
    for (id obj in self) {
        @autoreleasepool {
            id newObj = [obj performSelector:selector];
            if (newObj != nil) {
                [result addObject:newObj];
            }
        }
    }
    return result;
}

@end
