//
//  MRCRouter.m
//  YHRACMVVM
//
//  Created by yyh on 14/12/27.
//  Copyright (c) 2014年 yyh. All rights reserved.
//

#import "YHRouter.h"

@interface YHRouter ()

@end

@implementation YHRouter

+ (instancetype)sharedInstance {
    static YHRouter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (YHBaseViewController *)viewControllerForViewModel:(NSString *)route params:(NSDictionary *)params{
    
    if (!params) {
        params = @{};
    }
    
    YHBaseViewModel *baseViewModel = [self yh_getObjection:[NSClassFromString(route) class] argumentList:@[params]];
    //从路由中取出VC
    YHBaseViewController *viewController = (YHBaseViewController *)[self yh_getObjection:[baseViewModel class] name:route];
    
    SEL selector = NSSelectorFromString(@"initWithViewModel:");
    if ([[viewController class] instancesRespondToSelector:selector]) {
        
        Class VC = [viewController class];
        NSParameterAssert([VC isSubclassOfClass:[YHBaseViewController class]]);
        NSParameterAssert([VC instancesRespondToSelector:@selector(initWithViewModel:)]);
        viewController = ((id (*)(id,SEL,id))objc_msgSend)([VC  alloc],selector,baseViewModel);
        return viewController;
    }
    
    return nil;
}

@end
