//
//  ViewController.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHWeatherViewController.h"
#import "YHWeatherViewModel.h"
#import "YHWeatherTableViewCell.h"

@interface YHWeatherViewController ()
@property (nonatomic , strong , readwrite) YHWeatherViewModel *viewModel;
@property (nonatomic , strong , readwrite) UITableView *tableView;
@end

@implementation YHWeatherViewController
@dynamic viewModel;
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[YHWeatherTableViewCell class] forCellReuseIdentifier:NSStringFromClass([YHWeatherTableViewCell class])];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    
    YHWeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YHWeatherTableViewCell class])];
    
    if(!cell) { cell = [[YHWeatherTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YHWeatherTableViewCell class])];}
    
    return cell;
}

- (void)configureCell:(YHWeatherTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    [cell bindViewModel:object];
}

- (CGFloat)configureCellHeightAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    
    CGFloat height = [self.tableView fd_heightForCellWithIdentifier:NSStringFromClass([YHWeatherTableViewCell class]) cacheByIndexPath:indexPath configuration:^(YHWeatherTableViewCell *cell) {
        [cell bindViewModel:object];
    }];
    
    return height;
}

- (void)bindViewModel{
    [super bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
