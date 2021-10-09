// 
// 


#import "ZMSwiftExceptionHandler.h"


NSException * _Nullable zm_tryBlock(dispatch_block_t _Nonnull block) {
    @try {
        if (block != nil) {
            block();
        }
    }
    @catch (NSException *exception) {
        return exception;
    }
    return nil;
}

