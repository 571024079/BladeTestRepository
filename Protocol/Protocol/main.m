//
//  main.m
//  Protocol
//
//  Created by Ais on 2017/3/11.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkOrder.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        WorkOrder *wo = [WorkOrder new];
        wo.orderid = @111;
        [wo orderTotalPrice];
        
    }
    return 0;
}
