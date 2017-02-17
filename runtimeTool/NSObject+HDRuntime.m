//
//  NSObject+HDRuntime.m
//  ConditionBreakPoint
//
//  Created by Handlecar on 2017/2/13.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "NSObject+HDRuntime.h"
#import <objc/runtime.h>

#define hd_class ([self class])

@implementation NSObject (HDRuntime)

+ (NSArray *)getClassPropertys
{
    NSMutableArray *propertiesArray = [NSMutableArray array];
    
    unsigned int propertyCount;
    
    objc_property_t *properties = class_copyPropertyList(hd_class, &propertyCount);
    
    for (int i = 0; i < propertyCount; i++)
    {
        objc_property_t objc_property = properties[i];
        
        const char *propertyname = property_getName(objc_property);
        
        NSString *properyStringname = [NSString stringWithUTF8String:propertyname];
        
        [propertiesArray addObject:properyStringname];
    }
    return propertiesArray;
}

+ (NSArray *)getClassMethods
{
    NSMutableArray *methodArray = [NSMutableArray array];

    unsigned int methodCount;
    
     Method *methods = class_copyMethodList(hd_class, &methodCount);
    
    for (int i = 0; i < methodCount; i++)
    {
        Method method = methods[i];
        
        SEL methodSelector = method_getName(method);
        
        NSString *methodStringName = NSStringFromSelector(methodSelector);

        [methodArray addObject:methodStringName];
    }
    return methodArray;
}

- (void)hd_clearObjectPropertiesValue
{
    NSArray *ivarArray = [hd_class getClassVariablelist];
    
    for (NSString *ppname in ivarArray)
    {
        Ivar ivar = class_getInstanceVariable(hd_class, [ppname cStringUsingEncoding:NSUTF8StringEncoding]);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *classname = [NSString stringWithUTF8String:type];

        if ([classname hasPrefix:@"@"])
        {
            [self setValue:nil forKeyPath:ppname];
        }
        else
        {
            [self setValue:@0 forKeyPath:ppname];
        }
    }
}


// 获取该类所有属性变量
+ (NSArray *)getClassVariablelist
{
    NSMutableArray *ivarArray = [NSMutableArray array];

    unsigned int ivarCount;
    Ivar *ivars = class_copyIvarList(hd_class, &ivarCount);
    for (int i = 0; i< ivarCount; i++)
    {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        
        NSString *ivarName = [NSString stringWithUTF8String:name];
        [ivarArray addObject:ivarName];
    }
    return ivarArray;
}

@end
