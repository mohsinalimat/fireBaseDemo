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

@property int *ID;
@property BOOL gender;
@property NSString *name;
@property int *age;
@property UIImage *profileImage;
@property NSString *hobbies;

@end
