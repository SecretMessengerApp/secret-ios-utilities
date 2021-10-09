// 
// 


#import <Foundation/Foundation.h>



@interface NSOperationQueue (ZMQueueFactory)

+ (instancetype)zm_serialQueueWithName:(NSString *)name;

@end
