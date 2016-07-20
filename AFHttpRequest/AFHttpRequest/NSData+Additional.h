//
//  NSData+Additional.h
//  Handlecar
//
//  Created by liuzhaoxu on 14-9-30.
//  Copyright (c) 2014年 HanDu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Additional)

//解压
- (NSData *)gzipInflate;

//压缩
- (NSData *)gzipDeflate;

//加密
- (NSData *)DESEncryptWithKey:(NSString *)key;

//解密
- (NSData *)DESDecryptWithKey:(NSString *)key;

@end
