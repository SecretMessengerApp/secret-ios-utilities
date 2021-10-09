// 
// 


#import <Foundation/Foundation.h>


@class ZMTimer;

@protocol ZMTimerClient

- (void)timerDidFire:(ZMTimer *)timer;

@end

typedef NS_ENUM(NSUInteger, ZMTimerState) {
    ZMTimerStateNotStarted,
    ZMTimerStateStarted,
    ZMTimerStateFinished
};

@interface ZMTimer : NSObject

@property (nonatomic) NSDictionary *userInfo;

@property (nonatomic, readonly) ZMTimerState state;
@property (nonatomic, readonly, weak) id<ZMTimerClient> target;

+ (instancetype)timerWithTarget:(id<ZMTimerClient>)target;
+ (instancetype)timerWithTarget:(id<ZMTimerClient>)target operationQueue:(NSOperationQueue *)queue;

- (void)fireAtDate:(NSDate *)date;
- (void)fireAfterTimeInterval:(NSTimeInterval)interval;
- (void)cancel;

@end
