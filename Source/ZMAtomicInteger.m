//
//

#import "ZMAtomicInteger.h"
#import <stdatomic.h>

@implementation ZMAtomicInteger
{
    atomic_int _atomicValue;
}

- (instancetype)initWithInteger:(NSInteger)integer;
{
    self = [super init];
    if (self) {
        atomic_store(&_atomicValue, integer);
    }
    return self;
}

- (NSInteger)rawValue
{
    return atomic_load(&_atomicValue);
}

- (NSInteger)increment
{
    atomic_fetch_add(&_atomicValue, 1);
    return atomic_load(&_atomicValue);
}

- (NSInteger)decrement
{
    atomic_fetch_sub(&_atomicValue, 1);
    return atomic_load(&_atomicValue);
}

- (BOOL)setValueWithEqualityCondition:(NSInteger)condition newValue:(NSInteger)newValue;
{
    int expected = (int)condition;
    int desired = (int)newValue;
    return atomic_compare_exchange_strong(&_atomicValue, &expected, desired);
}

@end
