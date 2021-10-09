// 
// 

    

//This only works if com.apple.CoreData.ConcurrencyDebug is enabled
#define ZMAssertGroupQueue(_queue)	\
    do { \
        ((NSManagedObjectContext *)_queue).userInfo; \
    } while(0)

