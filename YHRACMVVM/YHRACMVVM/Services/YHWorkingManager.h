//
//  YHWorkingManager.h
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  @param response 请求成功返回的数据
 */
typedef void (^YHResponseSuccess)(NSURLSessionDataTask * task,id responseObject);

/**
 *  @param error 报错信息
 */
typedef void (^YHResponseFail)(NSURLSessionDataTask * task, NSError * error);


@interface YHWorkingManager : NSObject

+ (YHWorkingManager *)shareManager;

/**
 *  @param path           请求的地址
 *  @param paramters      请求的参数
 */
- (void)sendGETDataWithPath:(NSString *)path
               withParamters:(NSDictionary *)paramters
                     success:(YHResponseSuccess)success
                     failure:(YHResponseFail)failure;

/**
 *  @param path           请求的地址
 *  @param paramters      请求的参数
 */
- (void)sendPOSTDataWithPath:(NSString *)path
               withParamters:(NSDictionary *)paramters
                     success:(YHResponseSuccess)success
                     failure:(YHResponseFail)failure;


/**
 *  取消指定的url请求
 */
- (void)cancelAllNetworkRequest;

/**
 *  @param type 该请求的请求类型
 *  @param path 该请求的完整url
 */
- (void)cancelHttpRequestWithType:(NSString *)type WithPath:(NSString *)path;

@end
