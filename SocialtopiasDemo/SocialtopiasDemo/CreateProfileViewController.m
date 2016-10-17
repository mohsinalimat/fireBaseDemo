//
//  CreateProfileViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "CreateProfileViewController.h"
#import "PostProfile.h"

@interface CreateProfileViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *hobbiesTextfield;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (strong, nonatomic)NSNumber* currentGender;

@end

@implementation CreateProfileViewController

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextfield.delegate = self;
    self.ageTextfield.delegate = self;
    self.hobbiesTextfield.delegate = self;
    // Do any additional setup after loading the view.
    self.enterButton.hidden = YES;
}

#pragma mark - textfield delegate methods

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self checkForValidNameField] == YES && [self checkForValidAgeField] == YES && [self checkForValidHobbiesField] == YES) {
        self.enterButton.hidden = NO;
    }else{
        self.enterButton.hidden = YES;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - textfield validation

- (BOOL)checkForValidNameField{
    if ([self.nameTextfield.text length] < 1 || [self.nameTextfield.text length] > 50) {
        return NO;
    }
    return YES;
}

- (BOOL)checkForValidAgeField{
    int intValue = [self.ageTextfield.text intValue];
    if (intValue < 120 || intValue > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)checkForValidHobbiesField{
    if ([self.hobbiesTextfield.text length] < 1 || [self.nameTextfield.text length] > 200) {
        return NO;
    }
    return YES;
}

#pragma mark - button actions

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)genderSegmentController:(UISegmentedControl *)sender {
    self.currentGender = [[NSNumber alloc]initWithInteger:sender.selectedSegmentIndex];
}

- (IBAction)enter:(id)sender {
    [self post];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Post

- (void)post{
    
    UIImage *profileImage = [Profile setImageBasedOnGender:self.currentGender];
    
    Profile *profile = [[Profile alloc]initWithName:self.nameTextfield.text iD:self.iD isMale:self.currentGender age:[PostProfile formatAgeForPost:self.ageTextfield.text] profileImage: profileImage hobbies:self.hobbiesTextfield.text];
    
    PostProfile *post = [[PostProfile alloc]initWithDatabaseReference:self.ref profile:profile];
    [post postProfileWithID:self.iD];
    [self resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
