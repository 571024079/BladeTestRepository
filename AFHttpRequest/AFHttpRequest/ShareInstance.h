//
//  ShareInstance.h
//  AFHttpRequest
//
//  Created by Handlecar on 16/7/20.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareInstance : NSObject
@property (nonatomic, strong) NSNumber *staffId;//员工id
@property (nonatomic, strong) NSString *staffName;//员工名称
@property (nonatomic, strong) NSNumber *positionId;//职位id
@property (nonatomic, strong) NSNumber *dpId;//部门id
@property (nonatomic, strong) NSString *dpName;//部门名称
@property (nonatomic, strong) NSNumber *srid;//权限ID
@property (nonatomic, strong) NSString *srname;//权限名称
@property (nonatomic, strong) NSString *srcode;//权限code

@property (nonatomic, strong) NSString *rightFlag;//标识是否使用新权限 0为老权限，1为新权限
@property (nonatomic, strong) NSArray *srlist;//权限

@property (nonatomic, strong) NSString *pwdStr;//密码md5

@property (nonatomic, strong) NSNumber *checkedlogin; //  0登录成功     1用户名不存在     2密码错误   3登录权限禁用
@property (nonatomic, strong) NSString *companyaddress;//车行地址
@property (nonatomic, strong) NSString *companyname;
@property (nonatomic, strong) NSString *companytelno;
+ (ShareInstance *)shareInstance;
+ (ShareInstance *)dataFromJson:(NSDictionary *)dict;

@end
