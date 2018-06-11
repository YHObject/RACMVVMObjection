//
//  ModelA.h
//  YHRACMVVM
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseModel.h"

@interface YHWeatherDetailModel : YHBaseModel
@property (nonatomic,copy)NSString *title;
@end

@protocol YHWeatherDetailModel
@end


@interface YHWeatherModel : YHBaseModel
@property (nonatomic,strong)NSArray<YHWeatherDetailModel> *list;
@end
