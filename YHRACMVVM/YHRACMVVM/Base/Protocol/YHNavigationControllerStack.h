//
//  YHNavigationControllerStack.h
//  YHRACMVVM
//
//  Created by yyh on 15/1/10.
//  Copyright (c) 2015年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YHViewModelServicesProtocol;

@interface YHNavigationControllerStack : NSObject

/**
 *  设置Services
 */
- (instancetype)initWithServices:(id<YHViewModelServicesProtocol>)services;


/**
 *  获取栈顶的NavVC
 *
 *  @return
 */
- (UINavigationController *)topNavigationController;

@end
