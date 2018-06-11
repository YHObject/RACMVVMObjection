//
//  YHWeatherDetailViewController.m
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHWeatherDetailViewController.h"
#import "YHWeatherDetailViewModel.h"

@interface YHWeatherDetailViewController ()
@property (nonatomic , strong , readwrite) YHWeatherDetailViewModel *viewModel;
@property (nonatomic , strong) UILabel *titleLabel;
@end

@implementation YHWeatherDetailViewController
@dynamic viewModel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(@15);
        make.right.equalTo(@-15);
    }];
}

- (void)bindViewModel
{
    [super bindViewModel];
    
    [[RACObserve(self.viewModel, model) distinctUntilChanged] subscribeNext:^(YHWeatherDetailViewModel *model) {
        self.titleLabel.text = model.title;
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [self.view addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
