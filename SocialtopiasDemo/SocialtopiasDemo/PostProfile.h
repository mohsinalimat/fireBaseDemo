//
//  PostProile.h
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;
#import "Profile.h"

@interface PostProfile : NSObject

@property(strong, nonatomic) FIRDatabaseReference* databaseReference;
@property(strong, nonatomic) Profile* profile;

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference profile:(Profile*)profile;

-(void)postProfileWithID:(NSNumber*)iD;

+ (NSNumber*)formatAgeForPost:(NSString*)text;

@end
