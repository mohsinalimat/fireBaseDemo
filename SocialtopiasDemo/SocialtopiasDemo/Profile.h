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
@property (nonatomic)int iD;
@property (nonatomic)BOOL isFemale;
@property (nonatomic)int age;
@property (strong, nonatomic)UIImage *profileImage;
@property (strong, nonatomic)NSString *hobbies;

-(instancetype)initWithName: (NSString*)name iD:(int)iD isFemale:(BOOL)isFemale age:(int)age profileImage:(UIImage*)profileImage hobbies:(NSString*)hobbies;

@end
