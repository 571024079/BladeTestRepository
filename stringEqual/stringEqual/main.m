//
//  main.m
//  stringEqual
//
//  Created by Handlecar on 16/5/18.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSString *str =[NSString stringWithFormat:@"%@", @"12311111111111"];
        NSNumber *num = @12311111111111;
        NSLog(@"str addr %p",str);
        NSLog(@"num addr %p",[num stringValue]);
        NSArray *array = @[str];
        if ([array containsObject:[num stringValue]])
        {
            NSLog(@"0.0.0.0");
        }
        
        if ([[num stringValue] isEqual:str])
        {
            NSLog(@"111111111");
        }
    }
    return 0;
}
