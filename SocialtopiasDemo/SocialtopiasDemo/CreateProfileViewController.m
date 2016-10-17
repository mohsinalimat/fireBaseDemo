//
//  CreateProfileViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "CreateProfileViewController.h"
#import "PostProfile.h"


@interface CreateProfileViewController ()<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *hobbiesTextfield;

@property (strong, nonatomic) UIImagePickerController* imagePickerController;

@property (strong, nonatomic)NSNumber* currentGender;

@end

@implementation CreateProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imagePickerController.delegate = self;
    // Do any additional setup after loading the view.
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
