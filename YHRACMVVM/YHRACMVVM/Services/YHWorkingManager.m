//
//  YHWorkingManager.m
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHWorkingManager.h"

@implementation YHWorkingManager

static YHWorkingManager * workingManager = nil;

+ (YHWorkingManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (workingManager == nil) {
            workingManager = [[YHWorkingManager alloc] init];
        }
    });
    
    return workingManager;
}

/**
 *  @param path           请求的地址
 *  @param paramters      请求的参数
 */
- (void)sendGETDataWithPath:(NSString *)path
               withParamters:(NSDictionary *)paramters
                     success:(YHResponseSuccess)success
                     failure:(YHResponseFail)failure {
    
    [[self HTTPSessionManager] GET:path parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress = %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        if (success) {
            
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
        if (failure) {
            
            failure(task,error);
        }
    }];
}

/**
 *  @param path           请求的地址
 *  @param paramters      请求的参数
 */
- (void)sendPOSTDataWithPath:(NSString *)path
               withParamters:(NSDictionary *)paramters
                     success:(YHResponseSuccess)success
                     failure:(YHResponseFail)failure {
    
    [[self HTTPSessionManager] POST:path parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress = %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject = %@",responseObject);
        if (success) {
            
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error = %@",error);
        if (failure) {
            
            failure(task,error);
        }
    }];
}

/**
 *  取消指定的url请求
 */
- (void)cancelAllNetworkRequest {
    
    [[self HTTPSessionManager].operationQueue cancelAllOperations];
}

/**
 *  @param type 该请求的请求类型
 *  @param path 该请求的完整url
 */
- (void)cancelHttpRequestWithType:(NSString *)type WithPath:(NSString *)path {
    
    NSError * error;
    
    NSString * urlToPeCanced = [[[[self HTTPSessionManager].requestSerializer requestWithMethod:type URLString:path parameters:nil error:&error] URL] path];
    
    for (NSOperation * operation in [self HTTPSessionManager].operationQueue.operations) {
        
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            
            BOOL hasMatchRequestType = [type isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            
            
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            
            if (hasMatchRequestType&&hasMatchRequestUrlString) {
                
                [operation cancel];
            }
        }
    }
}

- (AFHTTPSessionManager *)HTTPSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer.timeoutInterval = 5.0;
    return manager;
}

@end
