//
//  ViewController.m
//  ForegroundDownload
//
//  Created by Handlecar on 16/3/1.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *urlString = @"http://h.hiphotos.baidu.com/image/pic/item/b7fd5266d0160924842b3f21d30735fae6cd34f9.jpg";
    NSString *filePath = @"/Users/Handlecar/Desktop/";
    if (urlString)
    {
        NSURLSessionTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"location url %@,response status %d, error %@",location,((NSHTTPURLResponse *)response).statusCode,error.localizedDescription);
        }];
        [task resume];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
