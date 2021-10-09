// 
// 


@import WireSystem;

#import "NSString+Normalization.h"


@implementation NSString (Normalization)

- (instancetype)normalizedInternal
{
    NSMutableString *string = [self mutableCopy];

    CFRange range = CFRangeMake(0, (NSInteger)string.length);
    Boolean success = CFStringTransform((__bridge CFMutableStringRef)string, &range, (__bridge CFStringRef) @"Any-Latin; Latin-ASCII; Lower", NO);
    VerifyString(success, "Unable to normalize string");
    return string;
}

- (instancetype)normalizedEmailaddress;
{
    return [self normalizedInternal];
}

- (instancetype)normalizedForSearch
{
    NSString *string = [self stringByFoldingWithOptions:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch locale:nil];
    return string.removePunctuationCharacters;
}

- (instancetype)normalizedForMentionSearch
{
    return [self stringByFoldingWithOptions:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch locale:nil];
}

- (instancetype)normalizedString;
{
    NSString *string = [self normalizedEmailaddress];
    NSString *cleanedString = [string removeNonAlphaNumericCharacters];
    return cleanedString;
}

- (instancetype)removeNonAlphaNumericCharacters
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    NSCharacterSet *invertedSet = [characterSet invertedSet];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    scanner.charactersToBeSkipped = invertedSet;
    
    NSMutableString *result = [NSMutableString string];
    while (!scanner.atEnd) {
        NSString *subString;
        if ([scanner scanCharactersFromSet:characterSet intoString:&subString]) {
            [result appendString:subString];
        }
    }
    return result;
}

- (instancetype)removePunctuationCharacters
{
    return [[self componentsSeparatedByCharactersInSet:NSCharacterSet.punctuationCharacterSet] componentsJoinedByString:@""];
}

- (BOOL)zmHasOnlyWhitespaceCharacters
{
    __block BOOL hasOnlyWhitespaceCharacters = YES;
    
    [self enumerateLinguisticTagsInRange:NSMakeRange(0, self.length) scheme:NSLinguisticTagSchemeTokenType options:NSLinguisticTaggerOmitWhitespace orthography:nil usingBlock:^(NSString *tag, NSRange __unused tokenRange, NSRange __unused sentenceRange, BOOL *stop) {
        if (tag != nil) {
            *stop = YES;
            hasOnlyWhitespaceCharacters = NO;
            return;
        }
    }];
    
    return hasOnlyWhitespaceCharacters;
}


@end
