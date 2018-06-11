//
//  YHReactiveViewProtocol.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YHReactiveViewProtocol <NSObject>

/**
 *  View遵从这个协议进行与VM的绑定
 *
 */
- (void)bindViewModel:(id)viewModel;

@end
