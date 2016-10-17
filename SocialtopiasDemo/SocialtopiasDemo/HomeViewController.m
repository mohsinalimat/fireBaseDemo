//
//  ViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "HomeViewController.h"
#import "Profile.h"
#import "ProfileStore.h"
#import "PostProfile.h"
#import "ProileFilter.h"
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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
//    [self.dataS removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpProfileStore{
    self.dataS = [[NSMutableArray alloc]init];
    
    [_ref observeEventType: FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableDictionary* value = snapshot.value;
        id object = value[@"Profiles"];
   
        if([object isKindOfClass:[NSArray class]]){
            for (id item in object) {
                if (item) {
                    NSDictionary *imageData = item[@"profileImage"];
                    UIImage *profileImage = [self setImageForPost:imageData[@"image"]];
                    Profile *newProfile = [[Profile alloc]initWithName:item[@"name"] iD:item[@"id"] isMale:item[@"gender"] age:item[@"age"] profileImage:profileImage hobbies:item[@"hobbies"]];
                    [self.dataS addObject:newProfile];
                }
            }
        }
        [self.tableView reloadData];
        self.profileFilter.originaldatasource = self.dataS;
    }];
    
}

-(UIImage*)setImageForPost:(NSString*)imageData{
    NSData* data = [[NSData alloc] initWithBase64EncodedString:imageData options:0];
    UIImage* image = [UIImage imageWithData:data];

    return image;
}

-(void)setUp{
    self.ref = [[FIRDatabase database] reference];
    self.profileFilter = [[ProileFilter alloc]initWithDatasource:self.dataS];

}


-(NSString*)getGender:(NSNumber*)gender{
    if ([gender isEqual:@0]) {
        return @"Female";
    }else{
        return @"Male";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];

    Profile *currentPath = [_dataS objectAtIndex:indexPath.row];
    cell.backgroundColor = [self setColorForGender:currentPath.isMale];
    
    NSString *formattedGender = [self getGender:currentPath.isMale];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@", currentPath.name, currentPath.age, formattedGender];
    cell.homeCellImageView.image = currentPath.profileImage;
    cell.hobbiesLabel.text = [NSString stringWithFormat:@"Hobbies %@", currentPath.hobbies];
    return cell;
}

- (UIColor*)setColorForGender:(NSNumber*)gender{
    if ([gender  isEqual: @1]) {
        return  [UIColor blueColor];
    }else{
        return [self getPinkColor];
    }
}

-(UIColor*)getPinkColor{
    UIColor *pink = [[UIColor alloc]initWithRed: 255/255 green:200 / 255 blue:203 / 255 alpha:0.5];
    return  pink;
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
        NSString *formattedID = [NSString stringWithFormat:@"%@", profileToDelete.iD];
        
        [self.dataS removeObjectAtIndex:indexPath.row];
       
        NSLog(@"id %@", formattedID);
//        [[[self.ref child:@"Profiles"] child:formattedID]removeValue];
//        [self.ref updateChildValues:@{formattedPath : self.hobbiesTextfield.text}];
//        [[[self.ref child:@"Profiles"] child:formattedID] setValue:post];
        
        [tableView reloadData];

        
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
        
        NSNumber *lastProfileID = lastProfile.iD;
        int intValue = [lastProfileID intValue];
        NSNumber *newProfileID = [NSNumber numberWithInt:intValue + 1];
        
        if (self.dataS.count == 0) {
            newProfileID = @0;
        }
        NSLog(@"idxxxx %@", newProfileID);
        destinationViewController.iD = newProfileID;
    }
}
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
    self.profileFilter.datasource = self.dataS;
    self.dataS = [self.profileFilter clearFilter];
    [self.tableView reloadData];
    //FETCH
    [self setFilterNotSelected];
}

@end
