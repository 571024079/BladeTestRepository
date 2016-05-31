//
//  main.m
//  change
//
//  Created by Handlecar on 16/5/12.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

            for (NSInteger i = 1; i < 10; i++)
            {
                
                for (NSInteger j = 1; j <= i; j++)
                {
                    printf("%ld x %ld = %ld  ",j,i,i*j);
                }
                printf("\n");
            }
        }
    
    return 0;
}
