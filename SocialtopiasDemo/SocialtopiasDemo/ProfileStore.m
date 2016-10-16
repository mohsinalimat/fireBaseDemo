//
//  ProfileStore.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "ProfileStore.h"

@implementation ProfileStore

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference{
    
    if (self = [super init]){
        self.databaseReference = reference;
        [self getProfilesFromFirebase];
    }
    return self;
}

-(void)getProfilesFromFirebase{
    NSMutableArray *store = [[NSMutableArray alloc]init];
    [_databaseReference observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableDictionary* value = snapshot.value;
        NSLog(@"%@", value);
    }];
}

-(void)addProfile:(Profile*)profile{
    [_store addObject:profile];
}

-(void)removeProfileForID:(NSNumber*)iD{
    NSUInteger index = 0;
    for (Profile* profile in _store){
        index += 1;
        if (profile.iD == iD) {
            [_store removeObjectAtIndex:index];
        }
    }
}

@end
