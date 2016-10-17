//
//  CreateProfileViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "CreateProfileViewController.h"
#import "PostProfile.h"


@interface CreateProfileViewController ()<UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *hobbiesTextfield;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (strong, nonatomic) UIImagePickerController* imagePickerController;

@property (strong, nonatomic)NSNumber* currentGender;

@end

@implementation CreateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTextfield.delegate = self;
    self.ageTextfield.delegate = self;
    self.hobbiesTextfield.delegate = self;
//    self.imagePickerController.delegate = self;
    // Do any additional setup after loading the view.
    self.enterButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)checkForValidNameField{
    if ([self.nameTextfield.text length] < 1 || [self.nameTextfield.text length] > 50) {
        return NO;
    }
    return YES;
}

-(BOOL)checkForValidAgeField{
    int intValue = [self.ageTextfield.text intValue];
    if (intValue < 120 || intValue > 0) {
        return YES;
    }
    return NO;
}

-(BOOL)checkForValidHobbiesField{
    if ([self.hobbiesTextfield.text length] < 1 || [self.nameTextfield.text length] > 200) {
        return NO;
    }
    return YES;
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)addImage:(id)sender {
}
- (IBAction)genderSegmentController:(UISegmentedControl *)sender {
    self.currentGender = [[NSNumber alloc]initWithInteger:sender.selectedSegmentIndex];
}

- (IBAction)enter:(id)sender {
    [self post];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([self checkForValidNameField] == YES && [self checkForValidAgeField] == YES && [self checkForValidHobbiesField] == YES) {
        self.enterButton.hidden = NO;
    }else{
        self.enterButton.hidden = YES;
    }
    return YES;
}

-(void)post{
    UIImage *image = [UIImage imageNamed:@"turtles"];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *formattedNumber = [numberFormatter numberFromString:self.ageTextfield.text];
  
    Profile *profile = [[Profile alloc]initWithName:self.nameTextfield.text iD:self.iD isMale:self.currentGender age:formattedNumber profileImage: image hobbies:self.hobbiesTextfield.text];
    
    PostProfile *post = [[PostProfile alloc]initWithDatabaseReference:self.ref profile:profile];
    [post postProfileWithID:self.iD];
    [self resignFirstResponder];
}

@end
