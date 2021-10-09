// 
// 


@import WireSystem;
#import "ZMFunctional.h"


// We don't want "-Wincomplete-implementation" because some stuff is implemented
// inside ZMFunctional+noARC.m
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"


@implementation NSArray (ZMFunctional)

- (NSArray *)filterWithBlock:(BOOL(^)(id obj))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary<NSString *,id> * _Nullable __unused bindings) {
        return block != nil && block(evaluatedObject);
    }]];
}


- (instancetype)mapWithBlock:(id(^)(id obj))block;
{
    Require(block != nil);
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self) {
        id newObj = block(obj);
        if (newObj != nil) {
            [result addObject:newObj];
        }
    }
    return result;
}

- (instancetype)flattenWithBlock:(NSArray *(^)(id obj))block;
{
    Require(block != nil);
    NSMutableArray *result = [NSMutableArray array];
    for (id obj in self) {
        NSArray *newObj = block(obj);
        if ([newObj isKindOfClass:[NSArray class]] &&
            newObj.count > 0)
        {
            [result addObjectsFromArray:newObj];
        }
    }
    return result;
}

- (NSDictionary *)mapToDictionaryWithBlock:(NSDictionary *(^)(id))block
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (id item in self) {
        NSDictionary *itemDict = block(item);
        if ([itemDict isKindOfClass:[NSDictionary class]] && [itemDict count] > 0) {
            [dict addEntriesFromDictionary:itemDict];
        }
    }
    return [dict copy];
}

- (id)firstObjectMatchingWithBlock:(BOOL(^)(id obj))evaluator;
{
    Require(evaluator != nil);
    for(id object in self) {
        if(evaluator(object)) {
            return object;
        }
    }
    return nil;
}

- (NSArray *)objectsOfClass:(Class)desiredClass;
{
    NSMutableArray *array = [NSMutableArray array];
    for(id object in self) {
        if([object isKindOfClass:desiredClass]) {
            [array addObject:object];
        }
    }
    return array;
}

- (BOOL)containsObjectMatchingWithBlock:(BOOL(^)(id obj))evaluator ZM_NON_NULL(1);
{
    return ([self firstObjectMatchingWithBlock:evaluator] != nil);
}

@end


@implementation NSArray (Set)

- (NSSet *)set
{
    return [NSSet setWithArray:self];
}

- (NSOrderedSet *)orderedSet
{
    return [NSOrderedSet orderedSetWithArray:self];
}

@end


@implementation NSOrderedSet (ZMFunctional)

- (NSOrderedSet *)mapWithBlock:(id(^)(id obj))block;
{
    Require(block != nil);
    NSMutableOrderedSet *result = [NSMutableOrderedSet orderedSet];
    for (id obj in self) {
        id newObj = block(obj);
        if (newObj != nil) {
            [result addObject:newObj];
        }
    }
    return result;
}

- (NSOrderedSet *)objectsOfClass:(Class)desiredClass;
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSet];
    for(id object in self) {
        if([object isKindOfClass:desiredClass]) {
            [set addObject:object];
        }
    }
    return set;
}

@end



@implementation NSSet (ZMFunctional)

- (NSSet *)mapWithBlock:(id(^)(id obj))block;
{
    Require(block != nil);
    NSMutableSet *result = [NSMutableSet set];
    for (id obj in self) {
        id newObj = block(obj);
        if (newObj != nil) {
            [result addObject:newObj];
        }
    }
    return result;
}

- (NSSet *)objectsOfClass:(Class)desiredClass;
{
    NSMutableSet *set = [NSMutableSet set];
    for(id object in self) {
        if([object isKindOfClass:desiredClass]) {
            [set addObject:object];
        }
    }
    return set;
}

- (id)anyObjectMatchingWithBlock:(BOOL(^)(id obj))evaluator;
{
    Require(evaluator != nil);
    for(id object in self) {
        if(evaluator(object)) {
            return object;
        }
    }
    return nil;
}

@end


#pragma clang diagnostic pop
