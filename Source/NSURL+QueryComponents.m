// 
// 


#import "NSURL+QueryComponents.h"

@implementation NSURL (ZMQueryComponents)

- (NSDictionary *)zm_queryComponents;
{
    // TODO: use NSURLComponents here on 10.10
    
    // Parse the query:
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if (self.query != nil) {
        for (NSString *comp in [self.query componentsSeparatedByString:@"&"]) {
            NSArray *components = [comp componentsSeparatedByString:@"="];
            if(components.count > 2) {
                return @{};
            }
            NSString *key = components.firstObject;
            NSString *value = components.count > 1 ? components.lastObject : @"";
            query[key] = value;
        }
    }
    return query;
}

@end
