//
//  YHViewModelServicesImpl.m
//  YHRACMVVM
//
//  Created by yyh on 14/12/27.
//  Copyright (c) 2014年 yyh. All rights reserved.
//

#import "YHViewModelServicesImpl.h"

@implementation YHViewModelServicesImpl

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)pushViewTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated {}

- (void)popViewTo:(BOOL)animated {}

- (void)popToRootViewTo:(BOOL)animated {}

- (void)presentViewTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewTo:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootTo:(NSString *)route {}

@end
