//
//  AppModule.m
//  YHRACMVVM
//
//  Created by yyh on 2018/6/5.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "AppModule.h"
#import "YHWeatherViewController.h"
#import "YHWeatherViewModel.h"
#import "YHWeatherDetailViewModel.h"
#import "YHWeatherDetailViewController.h"
#import "YHViewModelProvider.h"
#import "YHViewModelServicesImpl.h"
#import "YHNavigationControllerStack.h"

@implementation AppModule

- (void)configure
{
    [self bindBlock:^id(JSObjectionInjector *context) {
        return [[YHViewModelServicesImpl alloc] init];
    } toProtocol:@protocol(YHViewModelServicesProtocol) inScope:JSObjectionScopeSingleton];
    
    
    [self bindProvider:[[YHViewModelProvider alloc] initWithClass:YHWeatherViewModel.self] toClass:[YHWeatherViewModel class] inScope:JSObjectionScopeNormal];
    [self bindClass:[YHWeatherViewController class] toClass:[YHWeatherViewModel class] named:Router_Weather];
    
    [self bindProvider:[[YHViewModelProvider alloc] initWithClass:YHWeatherDetailViewModel.self] toClass:[YHWeatherDetailViewModel class]];
    [self bindClass:[YHWeatherDetailViewController class] toClass:[YHWeatherDetailViewModel class] named:Router_WeatherDetail];
}

@end

@implementation NSObject(YHJSObjection)
- (id)yh_getObjection:(id)classOrProtocol{
    return [[JSObjection defaultInjector] getObject:classOrProtocol];
}

- (id)yh_getObjection:(id)classOrProtocol name:(NSString *)name{
    return [[JSObjection defaultInjector] getObject:classOrProtocol named:name];
}

-(id)yh_getObjection:(id)classOrProtocol argumentList:(NSArray *)argList{
    return [[JSObjection defaultInjector] getObject:classOrProtocol argumentList:argList];
}

-(id)yh_getObjection:(id)classOrProtocol params:(NSDictionary *)params{
    if (!params) {
        params = @{};
    }
    return [[JSObjection defaultInjector] getObject:classOrProtocol argumentList:@[params]];
}

@end
