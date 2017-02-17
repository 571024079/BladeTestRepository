//
//  NSObject+HDRuntime.h
//  ConditionBreakPoint
//
//  Created by Handlecar on 2017/2/13.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HDRuntime)

// 获取 类的属性列表(.h和.m中所有通过@property声明的属性)
+ (NSArray *)getClassPropertys;

// 获取 类的方法列表(.m中所有方法列表)
+ (NSArray *)getClassMethods;

// 清空所有属性的值
- (void)hd_clearObjectPropertiesValue;

@end
