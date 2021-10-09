// 
// 


#import <Foundation/Foundation.h>

@interface NSString (Normalization)

- (instancetype)normalizedString;
- (instancetype)normalizedForSearch;
- (instancetype)normalizedForMentionSearch;
- (instancetype)normalizedEmailaddress;

- (BOOL)zmHasOnlyWhitespaceCharacters;

@end
