//
//  PostProile.m
//  SocialtopiasDemo
//
//  Created by Vincent Smithers on 10/15/16.
//  Copyright © 2016 Vince Smithers. All rights reserved.
//

#import "PostProile.h"

@implementation PostProile

-(instancetype)initWithDatabaseReference:(FIRDatabaseReference*)reference{
    if (self = [super init]) {
        self.databaseReference = reference;
    }
    return self;
}
-(void)postProfile:(Profile*)profile{
    [[_databaseReference childByAutoId]setValue:profile];
}
@end
