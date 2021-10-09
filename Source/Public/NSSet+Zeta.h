// 
// 


#import <Foundation/Foundation.h>



@interface NSSet (Zeta)

+ (instancetype)zmSetByCompiningSets:(NSSet * const [])sets count:(NSUInteger)cnt;
+ (instancetype)zmSetByCompiningSets:(NSSet *)firstSet, ... NS_REQUIRES_NIL_TERMINATION;

@end
