//
//  HomeTableViewCell.h
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *homeCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hobbiesLabel;

@end
