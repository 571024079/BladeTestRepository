//
//  ViewController.m
//  SocketTest
//
//  Created by Handlecar on 16/5/23.
//  Copyright © 2016年 Socket. All rights reserved.
//

#import "ViewController.h"
#include <arpa/inet.h>
#include <netdb.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    NSString *host = @"192.168.131";
    NSNumber *port = @8080;
    
    // 创建socket AF_INET IPv4网络协议的套接字类型
    int socketFileEescritpor = socket(AF_INET, SOCK_STREAM, 0);
    if (socketFileEescritpor == - 1)
    {
        NSLog(@"创建失败");
        return;
    }
    
    // 获取 IP 地址
    struct hostent *remoteHostEnt = gethostbyname([host UTF8String]);
    if (NULL == remoteHostEnt)
    {
        close(socketFileEescritpor);
        NSLog(@"无法解析服务器的主机名");
    }
    struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
    
    // 设置 socket  参数
    struct sockaddr_in socketParameters;
    socketParameters.sin_family = AF_INET;
    socketParameters.sin_addr = *remoteInAddr;
    socketParameters.sin_port = htons([port integerValue]);
    
    // 连接 socket
    int ret = connect(socketFileEescritpor, (struct sockaddr *) &socketParameters, sizeof(socketParameters));
    if (ret == -1)
    {
        close(socketFileEescritpor);
        NSLog(@"连接失败");
        return;
    }
    else
    {
        strerror(errno);
    }
    NSLog(@"连接成功");
}

@end
