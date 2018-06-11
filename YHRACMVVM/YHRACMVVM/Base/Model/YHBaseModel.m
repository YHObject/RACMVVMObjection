//
//  BaseModel.m
//  YHRACMVVM
//
//  Created by yyh on 2018/5/4.
//  Copyright © 2018年 yyh. All rights reserved.
//

#import "YHBaseModel.h"
#import <objc/runtime.h>

@implementation YHBaseModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSArray *)propertyNames{
    NSMutableArray *array = objc_getAssociatedObject([self class], _cmd);
    if (array){
        return array;
    }
    
    array = [NSMutableArray array];
    Class subclass = [self class];
    while (subclass != [NSObject class]){
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(subclass,
                                                             &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++){
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = @(propertyName);
            
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar){
                NSString *ivarName = @(ivar);
                if ([ivarName isEqualToString:key] ||
                    [ivarName isEqualToString:[@"_" stringByAppendingString:key]]){
                    [array addObject:key];
                }
                free(ivar);
            }
        }
        free(properties);
        subclass = [subclass superclass];
    }
    
    objc_setAssociatedObject([self class], _cmd, array,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return array;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [self init])){
        for (NSString *key in [self propertyNames]){
            id value = [aDecoder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    for (NSString *key in [self propertyNames]){
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
}

@end
