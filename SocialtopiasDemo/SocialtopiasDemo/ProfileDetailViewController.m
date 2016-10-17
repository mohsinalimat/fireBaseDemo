//
//  DetailViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "ProfileDetailViewController.h"

@interface ProfileDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageGenderLabel;
@property (weak, nonatomic) IBOutlet UITextField *hobbiesTextfield;

@property (weak, nonatomic) IBOutlet UILabel *hobbiesLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hobbiesLabelTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property BOOL isEditing;

@end

@implementation ProfileDetailViewController

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpForSelectedProfile];
    // Do any additional setup after loading the view.
}

#pragma mark - set layout for profile data

- (void)setUpForSelectedProfile{
    self.nameLabel.text = self.selectedProfile.name;
    
    NSString *gender = [Profile getGender:self.selectedProfile.isMale];
    
    self.ageGenderLabel.text = [NSString stringWithFormat:@"%@ %@", self.selectedProfile.age, gender];
    self.hobbiesLabel.text = self.selectedProfile.hobbies;
    self.profileImageView.image = self.selectedProfile.profileImage;
    
    [self setLayoutForNotEditing];

    self.hobbiesLabelTopConstraint.constant = 8;
}

#pragma mark - toggle layout for editing state

- (void)setLayoutForNotEditing{
    self.hobbiesTextfield.hidden = YES;
    self.hobbiesLabel.hidden = NO;
    self.hobbiesLabelTopConstraint.constant = 8;
    self.saveButton.hidden = YES;
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [_hobbiesTextfield resignFirstResponder];
    self.isEditing = YES;
}

- (void)setLayoutForEditing{
    self.hobbiesLabelTopConstraint.constant = 120;
    self.hobbiesTextfield.hidden = NO;
    self.hobbiesLabel.hidden = YES;
    self.saveButton.hidden = NO;
    [self.editButton setTitle:@"Cancel" forState:UIControlStateNormal];

    self.isEditing = NO;
}

#pragma mark - edit and save actions

- (IBAction)editHobbies:(id)sender {
    self.isEditing == true ? [self setLayoutForEditing] : [self setLayoutForNotEditing];
}

- (IBAction)save:(id)sender {
    
    NSString *formattedID = [NSString stringWithFormat:@"%@", self.selectedProfile.iD];
    NSString *formattedPath = [NSString stringWithFormat:@"/Profiles/%@/info/hobbies", formattedID];
    
    self.hobbiesLabel.text = self.hobbiesTextfield.text;

    [self.ref updateChildValues:@{formattedPath : self.hobbiesTextfield.text}];
    [self setLayoutForNotEditing];
    
    [_hobbiesTextfield resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
