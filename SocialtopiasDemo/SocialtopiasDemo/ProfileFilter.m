//
//  ProileFilter.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/17/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "ProfileFilter.h"
#import "Profile.h"

@implementation ProfileFilter

- (instancetype)initWithDatasource:(NSMutableArray*)datasource{
    if (self = [super init]) {
        self.datasource = datasource;
        self.originaldatasource = [datasource copy];
    }
    return self;
}

- (NSMutableArray*)sortByMale{
    NSMutableArray *filteredDatasouce = [[NSMutableArray alloc]init];
    for ( Profile *profile in self.datasource) {
        if ([profile.isMale isEqualToNumber:@1 ]) {
            [filteredDatasouce addObject:profile];
        }
    }
    return  filteredDatasouce;
}

- (NSMutableArray*)sortByFemale{
    NSMutableArray *filteredDatasouce = [[NSMutableArray alloc]init];
    for ( Profile *profile in self.datasource) {
        if ([profile.isMale isEqualToNumber:@0 ]) {
            [filteredDatasouce addObject:profile];
        }
    }
    return  filteredDatasouce;
}

- (NSMutableArray*)sortByAgeAscending{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    NSArray *filteredArray = [self.datasource sortedArrayUsingDescriptors:sortDescriptors];
    
    NSMutableArray *filteredDatasource = [[NSMutableArray alloc]initWithArray:filteredArray];
    return filteredDatasource;
}

- (NSMutableArray*)sortByAgeDescending{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    NSArray *filteredArray = [self.datasource sortedArrayUsingDescriptors:sortDescriptors];
    
    NSMutableArray *filteredDatasource = [[NSMutableArray alloc]initWithArray:filteredArray];
    return filteredDatasource;
}

- (NSMutableArray*)sortByNameAscending{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    NSArray *filteredArray = [self.datasource sortedArrayUsingDescriptors:sortDescriptors];
    
    NSMutableArray *filteredDatasource = [[NSMutableArray alloc]initWithArray:filteredArray];
    return filteredDatasource;
}

- (NSMutableArray*)sortByNameDescending{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO selector:@selector(caseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSMutableArray arrayWithObject:sortDescriptor];
    NSArray *filteredArray = [self.datasource sortedArrayUsingDescriptors:sortDescriptors];
    
    NSMutableArray *filteredDatasource = [[NSMutableArray alloc]initWithArray:filteredArray];
    return filteredDatasource;
}

- (NSMutableArray*)clearFilter{
    return self.originaldatasource;
}

@end
