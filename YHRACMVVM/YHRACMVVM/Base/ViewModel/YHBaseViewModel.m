//
//  YHBaseViewModel.m
//  YHCSimpleExample
//
//  Created by yyh on 2018/5/10.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseViewModel.h"

@interface YHBaseViewModel()

@property (nonatomic, strong, readwrite) id<YHViewModelServicesProtocol> services;
@property (nonatomic, copy, readwrite) NSDictionary *params;
@property (strong, nonatomic, readwrite) RACSubject *willDisappearSignal;
@property (strong, nonatomic, readwrite) RACSubject *willAppearSignal;
@property (strong, nonatomic, readwrite) RACReplaySubject *errors;
@property (strong, nonatomic, readwrite) RACSubject *loadings;

@end

@implementation YHBaseViewModel

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    YHBaseViewModel *viewModel = [super allocWithZone:zone];
    
    @weakify(viewModel)
    [[viewModel
      rac_signalForSelector:@selector(initWithServices:params:)]
     subscribeNext:^(id x) {
         @strongify(viewModel)
         [viewModel initialize];
     }];
    
    return viewModel;
}

- (instancetype)initWithServices:(id<YHViewModelServicesProtocol>)services params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        self.title    = params[@"title"];
        self.services = services;
        self.params   = params;
    }
    return self;
}

-(void)initialize
{
    
}

- (void)showErrorMessage:(NSString *)message
{
    [self.errors sendNext:RACTuplePack(@(YHTipType_Error),message)];
}

- (void)showFinishMessage:(NSString *)message
{
    [self.errors sendNext:RACTuplePack(@(YHTipType_Finish),message)];
}

- (RACSubject *)willDisappearSignal {
    if (!_willDisappearSignal) {
        _willDisappearSignal = [RACSubject subject];
    }
    return _willDisappearSignal;
}

-(RACSubject *)willAppearSignal{
    if (!_willAppearSignal) {
        _willAppearSignal = [RACSubject subject];
    }
    return _willAppearSignal;
}

-(RACReplaySubject *)errors{
    if (!_errors) {
        _errors = [RACReplaySubject subject];
    }
    return _errors;
}

-(RACSubject *)loadings{
    if (!_loadings) {
        _loadings = [RACSubject subject];
    }
    return _loadings;
}

NSString* message(NSError *error){
    
    return error.userInfo[NSLocalizedDescriptionKey];
}

@end
