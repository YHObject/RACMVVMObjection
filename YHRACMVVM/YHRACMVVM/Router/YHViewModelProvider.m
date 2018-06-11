//
//  YHViewModelProvider.m
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHViewModelProvider.h"
#import "YHBaseViewModel.h"

@implementation YHViewModelProvider

-(instancetype)initWithClass:(id)classObject{
    if (self = [super init]) {
        _classObject = classObject;
    }
    return self;
}

- (id)provide:(JSObjectionInjector *)context arguments:(NSArray *)arguments
{
    SEL selector = NSSelectorFromString(@"initWithServices:params:");
    if ([_classObject instancesRespondToSelector:selector]) {
        id service = [context getObject:@protocol(YHViewModelServicesProtocol)];
        return ((id (*)(id,SEL,id,id))objc_msgSend)([_classObject alloc],selector,service,arguments.firstObject);
    }
    
    return nil;
}

@end
