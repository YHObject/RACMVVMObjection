//
//  MBProgressHUD+YH.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/9.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YH)

/**
 显示一些信息
 
 @param messgae 信息内容
 */
+ (void)showMessage:(NSString *)messgae;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;


/**
 显示一带有图片的信息
*/
+ (void)showSuccessMessage:(NSString *)message;
+ (void)showSuccessMessage:(NSString *)message toView:(UIView *)view;
+ (void)showFailureMessage:(NSString *)message;
+ (void)showFailureMessage:(NSString *)message toView:(UIView *)view;

/**
 关闭
 */
+ (void)hideHUD;
@end
