//
//  PostProile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "PostProile.h"

@implementation PostProile

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference{
    if (self = [super init]) {
        self.databaseReference = reference;
    }
    return self;
}

-(void)postProfile:(Profile*)profile{
    
    NSMutableDictionary* post = [[NSMutableDictionary alloc]init];
    [post setValue:profile.name forKey:@"name"];
    [post setValue:profile.iD forKey:@"id"];
    [post setValue:[NSNumber numberWithBool:profile.isFemale] forKey:@"gender"];
    [post setValue:profile.age forKey:@"age"];
    [post setValue:profile.hobbies forKey:@"hobbies"];
    
    NSString *profileImage = [self setImageForPost:profile.profileImage];
    NSDictionary *imageDict = @{@"image" : profileImage};
    
    [post setValue:imageDict forKey:@"profileImage"];
    
    [[_databaseReference childByAutoId]setValue:post];
}

-(NSString*)setImageForPost:(UIImage*)image{
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

}

@end
