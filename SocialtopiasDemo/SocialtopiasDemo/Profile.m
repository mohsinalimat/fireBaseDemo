//
//  Profile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "Profile.h"

@implementation Profile

-(instancetype)initWithName: (NSString*)name iD:(NSNumber*)iD isMale:(NSNumber*)isMale age:(NSNumber*)age profileImage:(UIImage*)profileImage hobbies:(NSString*)hobbies{
    
    if (self == [super init]){
        self.name = name;
        self.iD = iD;
        self.isMale = isMale;
        self.age = age;
        self.profileImage = profileImage;
        self.hobbies = hobbies;
    }
    
    return self;
}



+(UIImage*)setImageForProfile:(NSString*)imageData{
    
    NSData* data = [[NSData alloc]initWithBase64EncodedString:imageData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage* image = [UIImage imageWithData:data];
    
    return image;
}

+(NSString*)getGender:(NSNumber*)gender{
    if ([gender isEqual:@0]) {
        return @"Female";
    }else{
        return @"Male";
    }
}

+ (UIImage*)setImageBasedOnGender:(NSNumber*)gender{
    
    if ([gender  isEqual: @0]) {
        return [UIImage imageNamed:@"woman"];
    }else{
        return [UIImage imageNamed:@"man"];
    }
    
}

+ (NSNumber*)incrementProfileID:(NSNumber*)iD{
    int intValue = [iD intValue];
    NSNumber *newProfileID = [NSNumber numberWithInt:intValue + 1];
    return newProfileID;
}


@end
