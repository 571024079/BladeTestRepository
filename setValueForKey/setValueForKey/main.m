//
//  main.m
//  setValueForKey
//
//  Created by Handlecar on 4/5/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Man.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        Man *man = [Man new];
        [man setValue:@"gggg" forKey:@"name"];
        NSLog(@"man.name:%@",man.name);
        [man setValue:@"bbbbb" forKey:@"_name"];  // 异曲同工
        NSLog(@"man.name:%@",man.name);
        
        
        Man *man1 = [Man new];
        man1.age = 4;
        man1.count = @4;
        
        NSDictionary *dict = @{@"age":@5,@"_count":@6};
        
        [man1 setValuesForKeysWithDictionary:dict];
        
        NSLog(@"age %d",man1.age);
        
        Man *man2 = [Man new];
        man2.age = 5;
        man2.count = @4;

        Man *man3 = [Man new];
        man3.age = 6;
        man3.count = @4;

        Man *man4 = [Man new];
        man4.age = 7;
        man4.count = @4;

        Man *man5 = [Man new];
        man5.age = 8;
        man5.count = @4;
        
        NSArray  *array = @[man1,man2,man3,man4,man5];

    }
    return 0;
}
