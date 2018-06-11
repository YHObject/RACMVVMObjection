//
//  YHWeatherDetailViewModel.m
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHWeatherDetailViewModel.h"

@interface YHWeatherDetailViewModel()
@property (nonatomic , copy , readwrite) YHWeatherDetailViewModel *model;
@end


@implementation YHWeatherDetailViewModel

- (instancetype)initWithServices:(id<YHViewModelServicesProtocol>)services params:(NSDictionary *)params
{
    self = [super initWithServices:services params:params];
    if (self) {
        self.model = params[@"detailModel"];
    }
    return self;
}

@end
