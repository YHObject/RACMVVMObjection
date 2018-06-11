//
//  YHBaseTableViewModel.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/30.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseTableViewModel.h"

@interface YHBaseTableViewModel();
@end

@implementation YHBaseTableViewModel

- (void)initialize
{
    [super initialize];
    self.page = 1;
    self.perPage = 10;
}

-(RACCommand *)requestRemoteDataCommand{
    if (!_requestRemoteDataCommand) {
        @weakify(self)
        _requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
            @strongify(self)
            return [[self requestRemoteDataSignalWithPage:page ? page.unsignedIntegerValue:1] takeUntil:self.rac_willDeallocSignal];
        }];
        
    }
    return _requestRemoteDataCommand;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page
{
    return [RACSignal empty];
}

@end
