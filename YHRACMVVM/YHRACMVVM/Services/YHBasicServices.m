//
//  BasicServices.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBasicServices.h"
#import "YHWorkingManager.h"

@interface YHBasicServices()
@property (nonatomic,strong,readwrite) id model;
@end

@implementation YHBasicServices

+ (RACSignal *)excuteWithParams:(id)params formModelClass:(Class)modelClass
{
    YHBasicServices *basicServices = [[YHBasicServices alloc] init];
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[YHWorkingManager shareManager] sendGETDataWithPath:@"http://mobile.weather.com.cn/data/news/khdjson.htm?_=1381891660018" withParamters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [MBProgressHUD hideHUD];
            NSError *error;
            basicServices.model = [[modelClass alloc] initWithDictionary:responseObject error:&error];
            
            [subscriber sendNext:basicServices.model];
            [subscriber sendCompleted];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] setNameWithFormat:@"API - Signal - %@",NSStringFromClass(modelClass)] ;
}




@end
