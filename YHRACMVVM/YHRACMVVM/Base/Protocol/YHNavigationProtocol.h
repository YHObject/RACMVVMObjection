//
//  YHNavigationProtocol.h
//  YHRACMVVM
//
//  Created by yyh on 15/1/10.
//  Copyright (c) 2015年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHBaseViewModel;

typedef void (^VoidBlock)(void);

@protocol YHNavigationProtocol <NSObject>

/**
 *  push 到新的页面VC
 *
 *  @param route
 *  @param params
 *  @param animated
 */
- (void)pushViewTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated;

/**
 *  返回到上层VC
 *
 *  @param animated
 */
- (void)popViewTo:(BOOL)animated;

/**
 *  返回到根控制器VC
 *
 *  @param animated
 */
- (void)popToRootViewTo:(BOOL)animated;

/**
 *  展示从下到上pop一个视图（模态）VC
 *
 *  @param route
 *  @param params
 *  @param animated
 *  @param completion
 */
- (void)presentViewTo:(NSString *)route params:(NSDictionary *)params animated:(BOOL)animated completion:(VoidBlock)completion;

/**
 *  关闭一个模态视图VC
 *
 *  @param animated
 *  @param completion
 */
- (void)dismissViewTo:(BOOL)animated completion:(VoidBlock)completion;

/**
 *  keywindow的根控制器VC
 *
 *  @param route
 *  @param animated
 */
- (void)resetRootTo:(NSString *)route;
@end
