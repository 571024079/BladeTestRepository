//
//  main.m
//  ZombieObject
//
//  Created by Handlecar on 2017/3/23.
//  Copyright © 2017年 Han Dou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MYZZombie.h"

void PrintClassInfo(id obj) {
    Class cls = object_getClass(obj);
    Class superCls = class_getSuperclass(cls);
    
    NSLog(@"=== %s : %s ===",class_getName(cls),class_getName(superCls));
}
int main(int argc, const char * argv[]) {
    
    MYZZombie *mz = [[MYZZombie alloc] init];
    
    NSLog(@"before release");
    PrintClassInfo(mz);
    
    [mz release];
    NSLog(@"after release");
    
    PrintClassInfo(mz);
    
    return 0;
}
