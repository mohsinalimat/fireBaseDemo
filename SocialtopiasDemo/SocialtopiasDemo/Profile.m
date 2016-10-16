//
//  Profile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "Profile.h"

@implementation Profile


-(instancetype)initWithName: (NSString*)name iD:(NSNumber*)iD isFemale:(BOOL)isFemale age:(NSNumber*)age profileImage:(UIImage*)profileImage hobbies:(NSString*)hobbies{
    
    if (self == [super init]){
        self.name = name;
        self.iD = iD;
        self.isFemale = isFemale;
        self.age = age;
        self.profileImage = profileImage;
        self.hobbies = hobbies;
    }
    
    return self;
}

@end
