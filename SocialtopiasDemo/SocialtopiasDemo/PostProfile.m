//
//  PostProile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "PostProfile.h"

@implementation PostProfile

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference profile:(Profile*)profile{
    if (self = [super init]) {
        self.databaseReference = reference;
        self.profile = profile;
    }
    return self;
}

-(void)postProfileWithID:(NSNumber*)iD;{
    
    NSMutableDictionary* post = [[NSMutableDictionary alloc]init];
    
    [post setValue:self.profile.name forKey:@"name"];
    [post setValue:iD forKey:@"id"];
    [post setValue:[NSNumber numberWithBool:self.profile.isMale] forKey:@"gender"];
    [post setValue:self.profile.age forKey:@"age"];
    [post setValue:self.profile.hobbies forKey:@"hobbies"];
    
    NSString *profileImage = [self setImageForPost:self.profile.profileImage];
    NSDictionary *imageDict = @{@"image" : profileImage};
    
    [post setValue:imageDict forKey:@"profileImage"];
    NSString *formattedID = [NSString stringWithFormat:@"%@", iD];
    [[[_databaseReference child:@"Profiles"] child:formattedID] setValue:post];
}

-(NSString*)setImageForPost:(UIImage*)image{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

}

@end
