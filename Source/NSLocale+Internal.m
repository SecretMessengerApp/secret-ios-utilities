// 
// 


#import "NSLocale+Internal.h"

@implementation NSLocale (Internal)

+ (NSString *)getFirstSupportedLanguage
{
    for(NSString *language in [NSLocale preferredLanguages]) {
        if ([language hasPrefix:@"en"] || [language hasPrefix:@"de"]) {
            return language;
        }
    }
    return @"en";
}

+ (NSString *)formattedLocaleIdentifier;
{
    return [[self getFirstSupportedLanguage] stringByReplacingOccurrencesOfString:@"_" withString:@"-"];
}

@end
