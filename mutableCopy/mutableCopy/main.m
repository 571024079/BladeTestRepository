//
//  main.m
//  mutableCopy
//
//  Created by Handlecar on 16/6/14.
//  Copyright © 2016年 date. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSArray *array = @[@"1",@"2",@"3"];
        
        NSMutableArray *muarray = [array mutableCopy];
        
        [muarray removeObjectAtIndex:0];
        
    }
    return 0;
}
