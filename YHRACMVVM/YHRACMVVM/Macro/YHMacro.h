//
//  YHMacro.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/11.
//  Copyright © 2018年 yyh. All rights reserved.
//

#ifdef DEBUG
#define NSLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSLog( s, ... )
#endif
