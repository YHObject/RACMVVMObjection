//
//  MBProgressHUD+YH.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/9.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "MBProgressHUD+YH.h"

@implementation MBProgressHUD (YH)

/**
 显示一些信息
 
 @param messgae 信息内容
 */
+ (void)showMessage:(NSString *)messgae
{
    [self showMessage:messgae toView:nil];
}

/**
 显示一些信息
 
 @param message 信息内容
 @param view 需要显示信息的视图
 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    if(view == nil){
        view = [self fetchCurrenView];
    }
    // 快速显示一个显示信息
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.contentColor = [UIColor whiteColor];
    hub.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    hub.label.text = message;
}

+ (void)showSuccessMessage:(NSString *)message
{
    [self showSuccessMessage:message toView:nil];
}

+ (void)showSuccessMessage:(NSString *)message toView:(UIView *)view
{
    [self hideHUD];
    if(view == nil){
        view = [self fetchCurrenView];
    }
    // 快速显示一个显示信息
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeCustomView;
    hub.contentColor = [UIColor whiteColor];
    hub.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    hub.label.text = message;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TipViewIcon"]];
    [hub hideAnimated:YES afterDelay:1.0];
}

+ (void)showFailureMessage:(NSString *)message
{
    [self showFailureMessage:message toView:nil];
}

+ (void)showFailureMessage:(NSString *)message toView:(UIView *)view
{
    [self hideHUD];
    if(view == nil){
        view = [self fetchCurrenView];
    }
    // 快速显示一个显示信息
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeCustomView;
    hub.contentColor = [UIColor whiteColor];
    hub.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    hub.label.text = message;
    hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TipViewErrorIcon"]];
    [hub hideAnimated:YES afterDelay:1.0];
}

/**
 关闭
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 手动关闭MBProgressHUD
 
 @param view 显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view{
    if(view == nil){
        view = [self getCurrentViewController].view;
    }
    [self hideHUDForView:view animated:YES];
}

+ (UIView *)fetchCurrenView
{
    if([[self getCurrentViewController] isKindOfClass:[UIWindow class]]){
        return [UIApplication sharedApplication].keyWindow ;
    }
    return [self getCurrentViewController].view;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    //1、tabBarController
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //或者 UINavigationController * nav = tabbar.selectedViewController;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        //2、navigationController
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{//3、viewControler
        result = nextResponder;
    }
    return result;
}
@end
