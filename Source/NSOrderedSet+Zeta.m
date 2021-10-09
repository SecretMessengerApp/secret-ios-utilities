// 
// 


@import WireSystem;
#import "NSOrderedSet+Zeta.h"


@implementation NSOrderedSet (Zeta)

- (nullable NSObject *)firstObjectNotInSet:(NSSet *)set;
{
    NSMutableOrderedSet *copy = [self mutableCopy];
    [copy minusSet:set];
    return copy.firstObject;
}

@end



@implementation NSMutableOrderedSet (ZMSortedInsert)

- (void)zm_insertObject:(id)object sortedByDescriptors:(NSArray *)descriptors;
{
    Require(object != nil);
    Require(descriptors != nil);
    Require(descriptors.count != 0);
    NSComparator comparator = ^NSComparisonResult(id obj1, id obj2){
        for (NSSortDescriptor *sd in descriptors) {
            NSComparisonResult const r = [sd compareObject:obj1 toObject:obj2];
            if (r != NSOrderedSame) {
                return r;
            }
        }
        return NSOrderedSame;
    };
    NSRange const range = NSMakeRange(0, self.count);
    NSUInteger const idx = [self indexOfObject:object inSortedRange:range options:NSBinarySearchingInsertionIndex usingComparator:comparator];
    [self insertObject:object atIndex:idx];
}

- (void)zm_sortUsingComparator:(NSComparator)cmp valueGetter:(id(^)(id))getter
{
    [self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        id value1 = getter(obj1);
        id value2 = getter(obj2);
        
        return cmp(value1, value2);
    }];
}

@end



@implementation NSOrderedSet (ZMSorted)

- (id)firstObjectSortedByDescriptors:(NSArray *)descriptors;
{
    return [self firstObjectSortedByDescriptors:descriptors notInSet:nil];
}

- (id)firstObjectSortedByDescriptors:(NSArray *)descriptors notInSet:(nullable NSSet *)forbidden;
{
    NSComparator comparator = ^NSComparisonResult(id obj1, id obj2){
        for (NSSortDescriptor *sd in descriptors) {
            NSComparisonResult const r = [sd compareObject:obj1 toObject:obj2];
            if (r != NSOrderedSame) {
                return r;
            }
        }
        return NSOrderedSame;
    };
    
    id best;
    for (id candidate in self) {
        if ([forbidden containsObject:candidate]) {
            continue;
        }
        if (best == nil) {
            best = candidate;
        } else if (comparator(best, candidate) == NSOrderedDescending) {
            best = candidate;
        }
    }
    return best;
}

@end
