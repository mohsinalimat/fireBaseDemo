//
//  ProfileStore.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "ProfileStore.h"

@implementation ProfileStore

- (instancetype)init{
    
    if (self == [super init]){
        self.store = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)createProfilesFromSnapShot:(NSMutableDictionary*)data{

    id object = data[@"Profiles"];
    
    if([object isKindOfClass:[NSArray class]]){
        
        for (id item in object) {
            
            if ([item isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *profileDictionary = item[@"info"];
                NSDictionary *imageData = profileDictionary[@"profileImage"];
                UIImage *profileImage = [Profile setImageForProfile:imageData[@"image"]];
                
                Profile *newProfile = [[Profile alloc]initWithName:profileDictionary[@"name"] iD:profileDictionary[@"id"] isMale:profileDictionary[@"gender"] age:profileDictionary[@"age"] profileImage:profileImage hobbies:profileDictionary[@"hobbies"]];
                
                [self.store addObject:newProfile];
            }
        }
    }
}

@end
