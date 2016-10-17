//
//  ViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "HomeViewController.h"
#import "UIColor+UIColorCategory.h"
#import "Profile.h"
#import "ProfileStore.h"
#import "PostProfile.h"
#import "ProileFilter.h"
#import "RemoveProfile.h"
#import "HomeTableViewCell.h"
#import "ProfileDetailViewController.h"
#import "CreateProfileViewController.h"

@import Firebase;

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopContraint;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) ProfileStore *datasource;
@property (strong, nonatomic) NSMutableArray *dataS;
@property (strong, nonatomic) Profile *selectedProfile;

@property (strong, nonatomic) ProileFilter *profileFilter;

@end

@implementation HomeViewController

BOOL showFilterOptions = NO;
BOOL isEditing = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self setFilterNotSelected];
    [self setUpProfileStore];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)setUp{
    self.ref = [[FIRDatabase database] reference];
}


-(void)setUpProfileStore{
    self.dataS = [[NSMutableArray alloc]init];
    
    [_ref observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableDictionary* value = snapshot.value;
        
        //clear for fresh
        if (self.dataS.count != 0) {
            [self.dataS removeAllObjects];
        }
        
        id object = value[@"Profiles"];

        if([object isKindOfClass:[NSArray class]]){
            for (id item in object) {
                if ([item isKindOfClass:[NSDictionary class]]) {

                    NSDictionary *profileDictionary = item[@"info"];
                    NSDictionary *imageData = profileDictionary[@"profileImage"];
                    UIImage *profileImage = [Profile setImageForProfile:imageData[@"image"]];
                    
                    Profile *newProfile = [[Profile alloc]initWithName:profileDictionary[@"name"] iD:profileDictionary[@"id"] isMale:profileDictionary[@"gender"] age:profileDictionary[@"age"] profileImage:profileImage hobbies:profileDictionary[@"hobbies"]];
                    [self.dataS addObject:newProfile];
                }
            }
        }
        [self.tableView reloadData];
        self.profileFilter = [[ProileFilter alloc]initWithDatasource:self.dataS];
    }];
}

//-(void)clearDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];

    Profile *currentPath = [_dataS objectAtIndex:indexPath.row];
    cell.backgroundColor = [self setCellColorForGender:currentPath.isMale];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@, %@", currentPath.name, currentPath.age];
    cell.homeCellImageView.image = currentPath.profileImage;
    cell.hobbiesLabel.text = [NSString stringWithFormat:@"Hobbies: %@", currentPath.hobbies];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedProfile = [self.dataS objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView setEditing:NO animated:YES];
        
        Profile *profileToDelete = [_dataS objectAtIndex:indexPath.row];
        
        [self.dataS removeObjectAtIndex:indexPath.row];
       
        RemoveProfile *removeProfile = [[RemoveProfile alloc]initWithDatabaseReference:self.ref profile:profileToDelete];
        [removeProfile removePost];
        
        isEditing = NO;
        [tableView reloadData];
    }
}

- (UIColor*)setCellColorForGender:(NSNumber*)gender{
    if ([gender  isEqual: @1]) {
        return  [UIColor blueColor];
    }else{
        return [UIColor PinkColor];
    }
}

- (IBAction)edit:(id)sender {
    
    if (isEditing == YES) {
        [self.tableView setEditing:NO animated:YES];
        isEditing = NO;
    }else{
        [self.tableView setEditing:YES animated:YES];
        isEditing = YES;
    }
}

- (IBAction)showFilterOptions:(id)sender {
    
    if (showFilterOptions == NO){
        [self setFilterSelected];
        [self setUp];
    }else{
        [self setFilterNotSelected];
    }
}

-(void)setFilterSelected{
    _filterView.hidden = NO;
    _tableViewTopContraint.constant = 170.0;
     showFilterOptions = YES;
}

-(void)setFilterNotSelected{
    _filterView.hidden = YES;
    _tableViewTopContraint.constant = 0;
    showFilterOptions = NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"showDetail"]) {
        ProfileDetailViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.selectedProfile = self.selectedProfile;
        destinationViewController.ref = self.ref;
    }
    
    if ([segue.identifier isEqualToString:@"createProfile"]) {
        CreateProfileViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.ref = self.ref;
        Profile *lastProfile = self.dataS.lastObject;
        
        NSNumber *newProfileID = [Profile incrementProfileID:lastProfile.iD];
        
        if (self.dataS.count == 0) {
            newProfileID = @0;
        }
        destinationViewController.iD = newProfileID;
    }
}


#pragma mark - sort actions

- (IBAction)sortByWomen:(id)sender {
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter sortByFemale];
    [self.tableView reloadData];
    [self setFilterNotSelected];
}

- (IBAction)sortByMen:(id)sender {
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter sortByMale];
    [self.tableView reloadData];
    [self setFilterNotSelected];
}

- (IBAction)sortByAgeAscending:(id)sender {
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter sortByAgeAscending];
    [self.tableView reloadData];
    [self setFilterNotSelected];
}

- (IBAction)sortByAgeDescending:(id)sender {
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter sortByAgeDescending];
    [self.tableView reloadData];
    [self setFilterNotSelected];
}

- (IBAction)sortByNameAscending:(id)sender {
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter sortByNameAscending];
    [self.tableView reloadData];
    [self setFilterNotSelected];
}

- (IBAction)sortByNameDescending:(id)sender {
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter sortByNameDescending];
    [self.tableView reloadData];
    [self setFilterNotSelected];
}

- (IBAction)clearFilter:(id)sender {
    self.dataS = [self.profileFilter clearFilter];
    [self.tableView reloadData];

    [self setFilterNotSelected];
}



@end
