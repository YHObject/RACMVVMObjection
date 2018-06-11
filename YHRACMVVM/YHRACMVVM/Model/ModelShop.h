//
//  ModelA.h
//  RACSimpleExample
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseModel.h"

@interface ModelShopDetail : YHBaseModel
@property (nonatomic,copy)NSString                        *title;
@end

@protocol ModelShopDetail
@end

@protocol ModelArrKey
@end


@interface ModelArrKey : YHBaseModel
@property (nonatomic,strong)NSArray<ModelShopDetail>     *carousel;
@end


@interface WeatherModel : YHBaseModel
@property (nonatomic,strong)ModelArrKey                  *data;
@end
