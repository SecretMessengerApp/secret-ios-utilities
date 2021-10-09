// 
// 


#import <Foundation/Foundation.h>

// TODO move to ZMCSystem

/// Returns YES if the OS has support for Quality of Service for GCD / XPC / NSOperationQueue -- OS X 10.10 or iOS 8 an later.
extern BOOL ZMHasQualityOfServiceSupport(void) __attribute__((const));
