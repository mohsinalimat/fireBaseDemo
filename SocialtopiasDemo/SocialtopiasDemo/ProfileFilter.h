//
//  ProileFilter.h
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/17/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileFilter : NSObject

@property(strong, nonatomic) NSMutableArray* datasource;
@property(strong, nonatomic) NSMutableArray* originaldatasource;

- (instancetype)initWithDatasource:(NSMutableArray*)datasource;

- (NSMutableArray*)sortByMale;

- (NSMutableArray*)sortByFemale;

- (NSMutableArray*)sortByAgeAscending;

- (NSMutableArray*)sortByAgeDescending;

- (NSMutableArray*)sortByNameAscending;

- (NSMutableArray*)sortByNameDescending;

- (NSMutableArray*)clearFilter;

@end
