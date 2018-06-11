//
//  MRCRouter.h
//  YHRACMVVM
//
//  Created by yyh on 14/12/27.
//  Copyright (c) 2014年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBaseViewController.h"

@interface YHRouter : NSObject

+ (instancetype)sharedInstance;

- (YHBaseViewController *)viewControllerForViewModel:(NSString *)route params:(NSDictionary *)params;

@end

