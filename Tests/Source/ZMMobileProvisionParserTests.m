// 
// 


@import WireTesting;
@import WireUtilities;



@interface ZMMobileProvisionParserTests : ZMTBaseTest
@end



@implementation ZMMobileProvisionParserTests

- (void)testThatItParsesAppStoreSandbox;
{
    [self assertMatchingTeam:ZMProvisionTeamAppStore apsEnvironment:ZMAPSEnvironmentUnknown forProfileNamed:@"appstore-sandbox"];
}

- (void)testThatItParsesEnterpriseProduction;
{
    [self assertMatchingTeam:ZMProvisionTeamEnterprise apsEnvironment:ZMAPSEnvironmentProduction forProfileNamed:@"enterprise-production"];
}

- (void)testThatItParsesEnterpriseSandbox;
{
    [self assertMatchingTeam:ZMProvisionTeamEnterprise apsEnvironment:ZMAPSEnvironmentSandbox forProfileNamed:@"enterprise-sandbox"];
}

#pragma mark - Helper

- (void)assertMatchingTeam:(ZMProvisionTeam)team apsEnvironment:(ZMAPSEnvironment)environment forProfileNamed:(NSString *)profileName
{
    // given
    NSURL *profileURL = [self urlForBinaryProvisioningFileFromXMLWithName:profileName];
    
    // when
    ZMMobileProvisionParser *parser = [[ZMMobileProvisionParser alloc] initWithURL:profileURL];
    
    // then
    XCTAssertEqual(parser.team, team);
    XCTAssertEqual(parser.APSEnvironment, environment);
    XCTAssertTrue([NSFileManager.defaultManager removeItemAtURL:profileURL error:nil]);
}

- (NSURL *)urlForBinaryProvisioningFileFromXMLWithName:(NSString *)xmlPListFileName
{
    NSURL *xmlURL = [self fileURLForResource:xmlPListFileName extension:@"xml"];
    
    NSError *error;
    NSString *xml = [NSString stringWithContentsOfURL:xmlURL encoding:NSUTF8StringEncoding error:&error];
    XCTAssertNil(error);
    
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:xml format:NSPropertyListBinaryFormat_v1_0 options:0 error:&error];
    XCTAssertNil(error);
    
    NSURL *dataURL = [xmlURL.URLByDeletingLastPathComponent URLByAppendingPathComponent:@"profile.mobileprovision"];
    XCTAssertTrue([data writeToURL:dataURL atomically:YES]);
    
    return dataURL;
}

@end
