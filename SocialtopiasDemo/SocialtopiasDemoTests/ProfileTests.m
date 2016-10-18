//
//  ProfileTests.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/17/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Profile.h"

@interface ProfileTests : XCTestCase

@end

@implementation ProfileTests

Profile *testMaleProfile;
Profile *testFemaleProfile;

- (void)setUp {
    [super setUp];
    
    testMaleProfile = [[Profile alloc]initWithName:@"TestMale" iD:@11 isMale:@1 age:@32 profileImage:[UIImage imageNamed:@"man"] hobbies:@"testHobbiesMale"];
    testFemaleProfile = [[Profile alloc]initWithName:@"TestFemale" iD:@12 isMale:@0 age:@30 profileImage:[UIImage imageNamed:@"woman"] hobbies:@"testHobbiesFemail"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}


- (void)testIncrementProfileID{
    NSNumber *ten = [[NSNumber alloc]initWithInt:10];
    NSNumber *incrementedValue = [Profile incrementProfileID:ten];
    XCTAssertEqual(incrementedValue, @11);
}

-(void)testProfileImageMale{
    UIImage *image = [Profile setImageBasedOnGender:testMaleProfile.isMale];
    XCTAssertNotNil(image);
}

-(void)testProfileImageFemale{
    UIImage *image = [Profile setImageBasedOnGender:testFemaleProfile.isMale];
    XCTAssertNotNil(image);
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
