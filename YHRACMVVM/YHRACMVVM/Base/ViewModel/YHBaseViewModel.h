//
//  YHBaseViewModel.h
//  YHCSimpleExample
//
//  Created by yyh on 2018/5/10.
//  Copyright © 2018年 yyh. All rights reserved.
//

typedef NS_ENUM(NSInteger,YHTipType){
    YHTipType_Error,
    YHTipType_Finish
};

#import <Foundation/Foundation.h>
#import "YHViewModelProtocol.h"
@interface YHBaseViewModel : NSObject<YHViewModelProtocol>

@property (nonatomic ,assign ,readonly) YHTipType tipType;

/**
 *  初始化方法
 */
- (instancetype)initWithServices:(id<YHViewModelServicesProtocol>)services params:(NSDictionary *)params;
/**
 *  导航服务
 */
@property (nonatomic, strong, readonly) id<YHViewModelServicesProtocol> services;


/**
 *  初始化参数
 */
@property (nonatomic, copy, readonly) NSDictionary *params;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  页面消失的信号
 */
@property (strong, nonatomic, readonly) RACSubject *willDisappearSignal;
/**
 *  页面出现的信号
 */
@property (strong, nonatomic, readonly) RACSubject *willAppearSignal;
/**
 *  统一处理vm里面的所有错误
 */
@property (strong, nonatomic, readonly) RACReplaySubject *errors;
/**
 *  统一处理vm里面的所有loadings提示
 */
@property (strong, nonatomic, readonly) RACSubject *loadings;


- (void)showErrorMessage:(NSString *)message;
- (void)showFinishMessage:(NSString *)message;
NSString* message(NSError *error);
@end
