//
//  ShareInstance.m
//  AFHttpRequest
//
//  Created by Handlecar on 16/7/20.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ShareInstance.h"

@implementation ShareInstance

+ (ShareInstance *)shareInstance
{
    static ShareInstance *si = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        si = [[super allocWithZone:NULL] init];
    });
    
    return si;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [ShareInstance shareInstance];
}

+ (ShareInstance *)dataFromJson:(NSDictionary *)dict
{
    ShareInstance *si  = [[ShareInstance alloc] init];
    [si setValuesForKeysWithDictionary:dict];
    return si;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}



@end
