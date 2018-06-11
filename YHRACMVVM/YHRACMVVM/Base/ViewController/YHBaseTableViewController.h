//
//  YHBaseTableViewController.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/30.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseViewController.h"
#import "YHBaseTableViewModel.h"

@interface YHBaseTableViewController : YHBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong , readonly) UITableView *tableView;

/**
 *  重载数据
 */
- (void)reloadData;

/**
 *  用于在TabelViewDataSource中获取Cell，应在子类中重写
 *
 *  @param tableView
 *  @param identifier
 *  @param indexPath
 *
 *  @return
 */
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

/**
 *  子类重写，主要作用是Model和View之间的绑定
 *
 *  @param cell
 *  @param indexPath
 *  @param object
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

/**
 *  子类重写，主要配置cell高度
 *
 *  @param indexPath
 *  @param object
 */
- (CGFloat)configureCellHeightAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@end
