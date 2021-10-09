// 
// 


#import <Foundation/Foundation.h>



@interface NSData (ZMSorting)

- (NSComparisonResult)compare:(NSData *)otherData;

@end



@interface NSData (ZMHTTPCompression)

- (NSData *)zm_gzipCompressedHTTPBody;

@end
