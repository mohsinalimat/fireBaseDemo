//
//  ViewController.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/14/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopContraint;

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

- (IBAction)showFilterOptions:(id)sender {
    if (showFilterOptions == NO){
        [self setFilterSelected];
        showFilterOptions = YES;
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
