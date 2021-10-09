// 
// 


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSOrderedSet (Zeta)

- (nullable NSObject *)firstObjectNotInSet:(NSSet *)set;

@end




@interface NSMutableOrderedSet (ZMSortedInsert)

/// Inserts the object into a sorted ordered set.
/// Uses bibary search.
- (void)zm_insertObject:(id)object sortedByDescriptors:(NSArray *)descriptors;
- (void)zm_sortUsingComparator:(NSComparator)cmp valueGetter:(id(^)(id))getter;

@end



@interface NSOrderedSet (ZMSorted)

- (nullable id)firstObjectSortedByDescriptors:(NSArray *)descriptors;
- (nullable id)firstObjectSortedByDescriptors:(NSArray *)descriptors notInSet:(nullable NSSet *)forbidden;

@end

NS_ASSUME_NONNULL_END
