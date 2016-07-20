//
//  NSString+Additional.h
//  Handlecar
//
//  Created by liuzhaoxu on 14-8-22.
//  Copyright (c) 2014年 HanDou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)

/*
 * Returns the MD5 value of the string
 */
- (NSString*)md5;

- (NSString *)convertFromFormat:(NSString *)aFormat toAnotherFormat:(NSString *)bFormat;

- (BOOL)checkRegularExpression:(NSString*)regular regularOptions:(NSRegularExpressionOptions)regularOptions matchOptions:(NSMatchingOptions)matchOptions;
-(id)JSONValue;
@end
