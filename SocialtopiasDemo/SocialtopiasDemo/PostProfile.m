//
//  PostProile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "PostProfile.h"

@implementation PostProfile

- (instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference profile:(Profile*)profile{
    if (self = [super init]) {
        self.databaseReference = reference;
        self.profile = profile;
    }
    return self;
}

- (void)postProfileWithID:(NSNumber*)iD;{
    
    NSMutableDictionary* post = [[NSMutableDictionary alloc]init];

    NSString *formattedID = [NSString stringWithFormat:@"%@", iD];
    
    [post setValue:self.profile.name forKey:@"name"];
    [post setValue:iD forKey:@"id"];
    [post setValue:self.profile.isMale forKey:@"gender"];
    [post setValue:self.profile.age forKey:@"age"];
    [post setValue:self.profile.hobbies forKey:@"hobbies"];
    [post setValue:[self setImageDictionary] forKey:@"profileImage"];
    
    [[[_databaseReference child:@"Profiles"] child:formattedID] setValue:@{@"info":post}];
}

- (NSDictionary*)setImageDictionary{
    NSString *profileImage = [self setImageForPost:self.profile.profileImage];
    return @{@"image" : profileImage};
}
- (NSString*)setImageForPost:(UIImage*)image{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (NSNumber*)formatAgeForPost:(NSString*)text{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [numberFormatter numberFromString:text];
}

@end
