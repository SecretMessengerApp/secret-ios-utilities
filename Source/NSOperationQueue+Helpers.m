// 
// 


@import WireSystem;
#import "NSOperationQueue+Helpers.h"

@implementation NSOperationQueue (ZMQueueFactory)

+ (instancetype)zm_serialQueueWithName:(NSString *)name;
{
    NSOperationQueue *queue = [[self alloc] init];
    queue.maxConcurrentOperationCount = 1;
    queue.name = name;
    return queue;
}

@end

