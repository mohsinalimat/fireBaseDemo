//
//  ProfileStore.h
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
@import Firebase;

@interface ProfileStore : NSObject

@property(strong, nonatomic) FIRDatabaseReference* databaseReference;
@property(strong, nonatomic) NSMutableArray* store;

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference;

-(void)getProfilesFromFirebase;

-(void)addProfile:(Profile*)profile;
-(void)removeProfileForID:(NSNumber*)iD;

@end
