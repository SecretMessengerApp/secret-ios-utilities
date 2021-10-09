// 
// 



@import Foundation;


typedef NS_ENUM(int8_t, ZMAPSEnvironment) {
    ZMAPSEnvironmentUnknown = 0,
    ZMAPSEnvironmentProduction,
    ZMAPSEnvironmentSandbox,
};

typedef NS_ENUM(int8_t, ZMProvisionTeam) {
    ZMProvisionTeamUnknown = 0,
    ZMProvisionTeamAppStore,
    ZMProvisionTeamEnterprise,
};


@interface ZMMobileProvisionParser : NSObject

- (instancetype)initWithURL:(NSURL *)fileURL;

@property (nonatomic, readonly) ZMProvisionTeam team;
@property (nonatomic, readonly) ZMAPSEnvironment APSEnvironment;

@end
