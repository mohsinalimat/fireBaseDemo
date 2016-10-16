//
//  ViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "HomeViewController.h"
#import "Profile.h"
#import "PostProile.h"
@import Firebase;

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopContraint;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation HomeViewController

BOOL showFilterOptions = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFilterNotSelected];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUp{
    UIImage *image = [UIImage imageNamed:@"turtles"];
    Profile *example = [[Profile alloc]initWithName:@"Joe Smith" iD:@12 isFemale:YES age:@28 profileImage:image hobbies:@"Some Hobbies"];
    self.ref = [[FIRDatabase database] reference];
    PostProile *post = [[PostProile alloc]initWithDatabaseReference:_ref];
    [post postProfile:example];
//    [[_ref childByAutoId]setValue:@"testingljl;lkj"];
//    [[[[_ref child:@"Profiles"] child:@"test"] child:@"username"] setValue:@"txxxx"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"profileIdentifier"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (IBAction)showFilterOptions:(id)sender {
    if (showFilterOptions == NO){
        [self setFilterSelected];
        showFilterOptions = YES;
        [self setUp];
    }else{
        [self setFilterNotSelected];
        showFilterOptions = NO;
    }
}

-(void)setFilterSelected{
    _filterView.hidden = NO;
    _tableViewTopContraint.constant = 120.0;
}

-(void)setFilterNotSelected{
    _filterView.hidden = YES;
    _tableViewTopContraint.constant = 0;
}


@end
