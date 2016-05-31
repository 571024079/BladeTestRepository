//
//  main.m
//  addr
//
//  Created by Handlecar on 16/5/13.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <net/if.h>

NSString * localWiFiIPAddress()
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"] || [name isEqualToString:@"en1"])  // Wi-Fi adapter
                    return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSString *ip = localWiFiIPAddress();
        struct sockaddr_in server_addr;
        server_addr.sin_len = sizeof(struct sockaddr_in);
        server_addr.sin_family = AF_INET;
        server_addr.sin_port = htons(9100);
        server_addr.sin_addr.s_addr = inet_addr([@"192.168.200" UTF8String]);
        bzero(&(server_addr.sin_zero),8);
        
        int server_socket = socket(AF_INET, SOCK_STREAM, 0);
        if (server_socket == -1) {
            perror("socket error");
            return -1;
        }
        
        if (connect(server_socket, (struct sockaddr *)&server_addr, sizeof(struct sockaddr_in))==0)
        {
            return server_socket;
        }
        else
        {
            printf("can not connect to %s, exit!\n", argv[1]);
            printf("%s\n", strerror(errno));
            exit(1);
        }
        return -1;
        
    }
    return 0;
}

