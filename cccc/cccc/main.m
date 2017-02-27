//
//  main.m
//  cccc
//
//  Created by Handlecar on 4/15/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
  
        NSInteger i = [@"11A" integerValue]; // 后面不是数字的会被忽略
        NSInteger a = [@"11.A" integerValue]; // 后面不是数字的会被忽略
        CGFloat b = [@"11.1A" floatValue]; // 后面不是数字的会被忽略
        CGFloat c = [@"A11..A" floatValue]; // 后面不是数字的会被忽略

        NSLog(@"%d",i);
        NSLog(@"%d",a);
        NSLog(@"%f",b);
        NSLog(@"%f",c);
        
        // 只会把字符串出现第一个有效数字转换

    }
    return 0;
}
