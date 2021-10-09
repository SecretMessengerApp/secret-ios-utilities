// 
// 


#import <Foundation/Foundation.h>

// TODO move to ZMCSystem

@interface ZMQuickLookString : NSObject

- (void)appendHeader:(NSString *)text;
- (void)appendBodyText:(NSString *)text;
- (void)appendBodyTextWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)appendLabel:(NSString *)label text:(NSString *)text;
- (void)appendLabel:(NSString *)label textWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(2,3);

@property (nonatomic, readonly) NSAttributedString *text;

@end
