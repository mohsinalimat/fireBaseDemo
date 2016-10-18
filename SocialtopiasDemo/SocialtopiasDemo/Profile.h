//
//  Profile.h
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Profile : NSObject

@property (strong, nonatomic)NSString *name;
@property (nonatomic)NSNumber* iD;
@property (nonatomic)NSNumber* isMale;
@property (nonatomic)NSNumber* age;
@property (strong, nonatomic)UIImage *profileImage;
@property (strong, nonatomic)NSString *hobbies;

- (instancetype)initWithName: (NSString*)name iD:(NSNumber*)iD isMale:(NSNumber*)isMale age:(NSNumber*)age profileImage:(UIImage*)profileImage hobbies:(NSString*)hobbies;

+ (UIImage*)setImageForProfile:(NSString*)imageData;
+ (NSString*)getGender:(NSNumber*)gender;
+ (UIImage*)setImageBasedOnGender:(NSNumber*)gender;
+ (NSNumber*)incrementProfileID:(NSNumber*)iD;

@end
