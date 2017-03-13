//
//  main.m
//  BaseURL&RelativePathInteract
//
//  Created by Handlecar on 2017/3/13.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSURL *baseURL = [NSURL URLWithString:@"http://example.com:8788"];
        
        NSURL *url1 = [NSURL URLWithString:@"foo" relativeToURL:baseURL];
        NSURL *url2 = [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];
        NSURL *url3 = [NSURL URLWithString:@"/foo" relativeToURL:baseURL];
        NSURL *url4 = [NSURL URLWithString:@"foo/" relativeToURL:baseURL];
        NSURL *url5 = [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];
        NSURL *url6 = [NSURL URLWithString:@"http://example2.com" relativeToURL:baseURL];
        
        NSLog(@"url1 %@",url1);
        NSLog(@"url2 %@",url2);
        NSLog(@"url3 %@",url3);
        NSLog(@"url4 %@",url4);
        NSLog(@"url5 %@",url5);
        NSLog(@"url6 %@",url6);
    }
    return 0;
}
