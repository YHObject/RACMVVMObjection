//
//  YHBaseTableViewController.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/30.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseTableViewController.h"

@interface YHBaseTableViewController ()
@property (nonatomic , strong , readwrite) YHBaseTableViewModel *viewModel;
@property (nonatomic , strong , readwrite) UITableView *tableView;
@end

@implementation YHBaseTableViewController
@dynamic viewModel;

- (instancetype)initWithViewModel:(YHBaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        @weakify(self)
        [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
            @strongify(self)
            [self.viewModel.requestRemoteDataCommand execute:@1];
        }];
    }
    return self;
}

- (void)setView:(UIView *)view {
    [super setView:view];
    if ([view isKindOfClass:UITableView.class]) self.tableView = (UITableView *)view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
   
    
    @weakify(self);
    if (self.viewModel.shouldPullToRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            [[[self.viewModel.requestRemoteDataCommand execute:@1] deliverOnMainThread] subscribeNext:^(id x) {
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
            } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
            } completed:^{
                 @strongify(self)
                 [self.tableView.mj_header endRefreshing];
            }];
        }];
        
        if (self.viewModel.pullToRefreshTrigger) {
            [self.tableView.mj_header beginRefreshing];
        }
    }
    
    if (self.viewModel.shouldInfiniteScrolling) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [[[self.viewModel.requestRemoteDataCommand
               execute:@(self.viewModel.page + 1)]
              deliverOnMainThread]
             subscribeNext:^(NSArray *results) {
                 @strongify(self)
                 self.viewModel.page += 1;
             } error:^(NSError *error) {
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             } completed:^{
                 @strongify(self)
                 [self.tableView.mj_footer endRefreshing];
             }];
        }];
    }
}

- (void)bindViewModel
{
    [super bindViewModel];
    
    @weakify(self);
    [[[RACObserve(self.viewModel, dataSource) distinctUntilChanged] deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self);
        [self reloadData];
    }];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    
}

- (CGFloat)configureCellHeightAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    return 44.0f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataSource ? self.viewModel.dataSource.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    return [self configureCellHeightAtIndexPath:indexPath withObject:object];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.didSelectCommand execute:indexPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
