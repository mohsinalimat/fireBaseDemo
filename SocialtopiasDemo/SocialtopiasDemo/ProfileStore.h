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

@property(strong, nonatomic) NSMutableArray* store;

- (instancetype)init;

- (void)createProfilesFromSnapShot:(NSMutableDictionary*)data;

@end
