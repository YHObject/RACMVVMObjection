//
//  ViewModelA.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHWeatherViewModel.h"
#import "YHBasicServices.h"
#import "YHWeatherDetailViewModel.h"

@interface YHWeatherViewModel()

@end

@implementation YHWeatherViewModel

- (void)initialize
{
    [super initialize];
    self.title = @"RAC+MVVM+Objection";
    self.shouldPullToRefresh = YES;
    self.shouldInfiniteScrolling = YES;
}

- (RACCommand *)didSelectCommand
{
    @weakify(self);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPatht) {
        
        @strongify(self);
        [self.services pushViewTo:Router_WeatherDetail params:@{@"detailModel":self.dataSource[indexPatht.section][indexPatht.row]} animated:YES];
        return [RACSignal empty];
    }];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page
{
    @weakify(self);
    return [[[YHBasicServices excuteWithParams:nil formModelClass:YHWeatherModel.class] doNext:^(YHWeatherModel *model) {
        @strongify(self);
        self.dataSource = @[[model.list mutableCopy]];
    }] doError:^(NSError *error) {
        [self showErrorMessage:message(error)];
    }];
}

@end
