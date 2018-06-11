//
//  YHNavigationControllerStack.m
//  YHRACMVVM
//
//  Created by yyh on 15/1/10.
//  Copyright (c) 2015年 yyh. All rights reserved.
//

#import "YHNavigationControllerStack.h"
#import "YHRouter.h"
#import "AppModule.h"

@interface YHNavigationControllerStack () <UINavigationControllerDelegate>

@property (nonatomic, weak) id<YHViewModelServicesProtocol> services;
@property (nonatomic, strong) NSMutableArray<UINavigationController *> *navigationControllers;
@property (strong,nonatomic) NSMutableArray<UIViewController *> *presentControllers;

@end

@implementation YHNavigationControllerStack

- (instancetype)initWithServices:(id<YHViewModelServicesProtocol>)services {
    self = [super init];
    if (self) {
        _services = services;
        [self registerNavigationHooks];
        self.navigationControllers = [[NSMutableArray alloc] init];
        self.presentControllers = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    @synchronized (self) {
        if ([self.navigationControllers containsObject:navigationController]) return;
        [self.navigationControllers addObject:navigationController];
    }
}

- (void)presentController:(UIViewController *)viewController {
    @synchronized (self) {
        if ([self.presentControllers containsObject:viewController]) return;
        [self.presentControllers  addObject:viewController];
    }
}

- (UINavigationController *)popNavigationController {
    @synchronized (self) {
        UINavigationController *navigationController = self.navigationControllers.lastObject;
        [self.navigationControllers removeLastObject];
        return navigationController;
    }
}

- (UIViewController *)dissmissViewController {
    @synchronized (self) {
        UIViewController *presentController= self.presentControllers.lastObject;
        [self.presentControllers removeLastObject];
        return presentController;
    }
}

- (UINavigationController *)topNavigationController {
    @synchronized (self) {
        return self.navigationControllers.lastObject;
    }
}


- (void)registerNavigationHooks {
    
    @weakify(self)
    [[(NSObject *)self.services
        rac_signalForSelector:@selector(pushViewTo:params:animated:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
           
            YHBaseViewController *topViewController = (YHBaseViewController *)[self.navigationControllers.lastObject topViewController];
            UIViewController *viewController = (UIViewController *)[YHRouter.sharedInstance viewControllerForViewModel:tuple.first params:tuple.second];
            viewController.hidesBottomBarWhenPushed = YES;
            
            //防止打开同一个vc时候崩溃
            if ([self.topNavigationController.topViewController isEqual:viewController] || [viewController.childViewControllers containsObject:topViewController.tabBarController]) {
                return;
            }
            
            [self.navigationControllers.lastObject pushViewController:viewController animated:[tuple.third boolValue]];
        }];

    
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(popViewTo:)]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self)
         [self.navigationControllers.lastObject popViewControllerAnimated:[tuple.first boolValue]];
     }];
    
    [[(NSObject *)self.services
        rac_signalForSelector:@selector(popToRootViewTo:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            [self.navigationControllers.lastObject popToRootViewControllerAnimated:[tuple.first boolValue]];
        }];

    //present模式下，需要重写返回事件
    [[(NSObject *)self.services
      rac_signalForSelector:@selector(presentViewTo:params:animated:completion:)]
        subscribeNext:^(RACTuple *tuple) {
        	@strongify(self)
            UIViewController *viewController = (UIViewController *)[YHRouter.sharedInstance viewControllerForViewModel:tuple.first params:tuple.second];

            UINavigationController *presentingViewController = self.topNavigationController;
            
            //有导航条
            if (![viewController isKindOfClass:UINavigationController.class]) {
                viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
            }
            [self presentController:(UINavigationController *)viewController];

            [presentingViewController presentViewController:viewController animated:[tuple.third boolValue] completion:tuple.fourth];
            
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(dismissViewTo:completion:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            [self popNavigationController];
            [self.dissmissViewController dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
        }];

    [[(NSObject *)self.services
        rac_signalForSelector:@selector(resetRootTo:)]
        subscribeNext:^(RACTuple *tuple) {
            @strongify(self)
            [self.navigationControllers removeAllObjects];

            UIViewController *viewController = (UIViewController *)[YHRouter.sharedInstance viewControllerForViewModel:tuple.first params:nil];

            if (![viewController isKindOfClass:[UINavigationController class]] &&
                ![viewController isKindOfClass:[UITabBarController class]]) {
                viewController = [[UINavigationController alloc] initWithRootViewController:viewController];
                [self pushNavigationController:(UINavigationController *)viewController];
            }

            [UIApplication sharedApplication].delegate.window.rootViewController = viewController;
        }];
}
@end
