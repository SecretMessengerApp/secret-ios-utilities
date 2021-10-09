//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * An integer whose value is accessed and updated dynamically by the system.
 */

@interface ZMAtomicInteger : NSObject

/// The raw integer value managed by the system.
@property (nonatomic, readonly) NSInteger rawValue;

- (instancetype)initWithInteger:(NSInteger)integer;

/// Increments the integer value and returns the updated value.
- (NSInteger)increment;

/// Decrements the integer value and returns the updated value.
- (NSInteger)decrement;

/**
 * Checks if the current value is equal to the expected value. If the expected value is equal
 * to the current value, set the current value to the new value.
 * @param condition The condition to evaluate before updating the value.
 * @param newValue The value to set to the integer if the condition evaluated to `YES`.
 * @return Whether the condition evaluated to `YES`.
 */

- (BOOL)setValueWithEqualityCondition:(NSInteger)condition newValue:(NSInteger)newValue;

@end

NS_ASSUME_NONNULL_END
