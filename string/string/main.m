//
//  main.m
//  string
//
//  Created by Handlecar on 3/31/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        NSString *str = @"1111";
        NSString *str2 = str;
        str = @"";
        NSLog(@"%@",str2);
    }
    return 0;
}
