//
//  AppModule.h
//  YHRACMVVM
//
//  Created by yyh on 2018/6/5.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "JSObjectionModule.h"

@interface AppModule : JSObjectionModule

@end


@interface NSObject (YHJSObjection)
- (id)yh_getObjection:(id)classOrProtocol;
- (id)yh_getObjection:(id)classOrProtocol name:(NSString *)name;
- (id)yh_getObjection:(id)classOrProtocol params:(NSDictionary *)params;
- (id)yh_getObjection:(id)classOrProtocol argumentList:(NSArray *)argList;
@end
