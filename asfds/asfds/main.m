//
//  main.m
//  asfds
//
//  Created by Handlecar on 16/6/1.
//  Copyright © 2016年 date. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        @"/var/mobile/Containers/Data/Application/64439160-9201-4DF0-8ABF-B71ED4AAC72A/var/mobile/Containers/Data/Application/64439160-9201-4DF0-8ABF-B71ED4AAC72A/Documents/mobile/messagecenter.html?msgid=913";
        NSLog(@"%ld",[@"/var/mobile/Containers/Data/Application/64439160-9201-4DF0-8ABF-B71ED4AAC72A/var/mobile/Containers/Data/Application/64439160-9201-4DF0-8ABF-B71ED4AAC72A/Documents/mobile/messagecenter.html?msgid=913" length]);
        NSURL *url = [NSURL URLWithString:@"/var/mobile/Containers/Data/Application/64439160-9201-4DF0-8ABF-B71ED4AAC72A/var/mobile/Containers/Data/Application/64439160-9201-4DF0-8ABF-B71ED4AAC72A/Documents/mobile/messagecenter.html?msgid=913"];
        NSURLRequest *reqeust = [NSURLRequest requestWithURL:url];
        NSLog(@"url %@",url);
    }
    return 0;
}
