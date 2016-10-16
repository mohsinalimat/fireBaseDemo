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
        self.store = [self getProfilesFromFirebase];
    }
    return self;
}

-(NSMutableArray*)getProfilesFromFirebase{
    NSMutableArray *store = [[NSMutableArray alloc]init];
    [_databaseReference observeEventType: FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        id value = snapshot.value;
        NSLog(@"%@", value);
    }];
    return store;
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
