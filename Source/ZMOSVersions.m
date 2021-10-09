// 
// 


#import "ZMOSVersions.h"

BOOL ZMHasQualityOfServiceSupport(void)
{
    static BOOL hasQoS;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // The dispatch_block_create() function is only defined when the OS has QoS support.
        hasQoS = (&dispatch_block_create != NULL);
    });
    return hasQoS;
}
