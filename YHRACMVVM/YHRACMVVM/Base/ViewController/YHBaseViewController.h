//
//  BaseViewController.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHBaseViewModel.h"
@interface YHBaseViewController : UIViewController

//注意：所有子类都严格按照此viewModel命名，如果不一样需要从initWithViewModel拿值
@property (nonatomic, strong, readonly) YHBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(YHBaseViewModel *)viewModel;

- (void)bindViewModel;

@end
