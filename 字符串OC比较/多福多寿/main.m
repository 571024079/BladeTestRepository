//
//  main.m
//  多福多寿
//
//  Created by Handlecar on 16/6/2.
//  Copyright © 2016年 date. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
     
        if ([@"abc" compare:@"abc"] == NSOrderedAscending) // 不是升序
        {
            NSLog(@"dddd");
        }
        
        if ([@"abc" compare:@"abcd"] == NSOrderedAscending) // 是升序
        {
            NSLog(@"zzzz");
        }
        
        if ([@"abc" compare:@"abcd"] == NSOrderedSame)   // 不相等
        {
            NSLog(@"aaa");
        }
        else
        {
            NSLog(@"cccc");
        }
    }
    return 0;
}
