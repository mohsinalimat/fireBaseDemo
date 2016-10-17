//
//  DetailViewController.h
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"
@import Firebase;

@interface ProfileDetailViewController : UIViewController

@property(strong, nonatomic)Profile* selectedProfile;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
