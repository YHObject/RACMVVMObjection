//
//  YHBaseTableViewModel.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/30.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseViewModel.h"

@interface YHBaseTableViewModel : YHBaseViewModel

/**
 * 请求远程数据command
 */
@property (strong, nonatomic) RACCommand *requestRemoteDataCommand;

/**
 *  数据源，嵌套数组dataSource[section][row]
 */
@property (nonatomic , strong) NSArray<NSArray *> *dataSource;

/**
 *  当前页
 */
@property (assign, nonatomic) NSUInteger page;

/**
 *  每页数量
 */
@property (assign, nonatomic) NSUInteger perPage;

/**
 *  总数量
 */
@property (assign, nonatomic) NSUInteger totalCount;

/**
 *  是否支持下拉刷新
 */
@property (assign, nonatomic) BOOL shouldPullToRefresh;

/**
 *  是否支持上拉刷新
 */
@property (assign, nonatomic) BOOL shouldInfiniteScrolling;

/**
 *  触发下拉请求
 */
@property (assign, nonatomic) BOOL pullToRefreshTrigger;

/**
 *  Cell 选中的Action
 */
@property (strong, nonatomic) RACCommand *didSelectCommand;

/**
 *  根据页数请求服务端数据
 *
 *  @param page
 *
 *  @return
 */
- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;

@end
