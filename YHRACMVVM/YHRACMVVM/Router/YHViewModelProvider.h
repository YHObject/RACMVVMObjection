//
//  YHViewModelProvider.h
//  YHRACMVVM
//
//  Created by yyh on 2018/6/7.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHViewModelProvider : NSObject<JSObjectionProvider>

-(instancetype)initWithClass:(Class)classObject;

@property (strong,nonatomic,readonly) Class classObject;

@end
