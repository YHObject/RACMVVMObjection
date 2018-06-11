//
//  BasicServices.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHBasicServices : NSObject

+ (RACSignal *)excuteWithParams:(id)params formModelClass:(Class)modelClass;

@end
