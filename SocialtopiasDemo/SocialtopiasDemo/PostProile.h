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

@interface PostProile : NSObject

@property(strong, nonatomic) FIRDatabaseReference* databaseReference;

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference;
-(void)postProfile:(Profile*)profile;

@end
