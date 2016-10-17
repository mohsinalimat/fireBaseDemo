//
//  RemoveProfile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/17/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "RemoveProfile.h"

@implementation RemoveProfile

-(void)removePost{
    NSString *formattedID = [NSString stringWithFormat:@"%@", self.profile.iD];
    NSString *formattedPath = [NSString stringWithFormat:@"/%@/info", formattedID];

    [[[self.databaseReference child:@"Profiles"] child:formattedPath]removeValue];
}

@end
