//
//  ViewController.m
//  AFHttpRequest
//
//  Created by Handlecar on 16/7/20.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "ViewController.h"
#import "GlobalTimelineViewController.h"
#import "NSString+Additional.h"
#import "ShareInstance.h"
#import "NSData+Additional.h"
#import "HDBase64.h"
#import "AFAppDotNetAPIClient.h"

#define HDLoginPath                     @"if001/005"  // 登录

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UILabel *password;


- (IBAction)click:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)click:(id)sender {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:_username.text forKey:@"staffname"];
    [param setObject:_password.text forKey:@"password"];
    
    
    if ([ShareInstance shareInstance].staffId) {
        [param setObject:[ShareInstance shareInstance].staffId forKey:@"staffid"];
        [param setObject:[ShareInstance shareInstance].staffName forKey:@"staffname"];
        [param setObject:[ShareInstance shareInstance].pwdStr forKey:@"pwd"];

    }

    NSMutableDictionary *aaa = [NSMutableDictionary new];

     [aaa setObject:@2 forKey:@"clientflg"];//2表示iOS
    
    NSData* aaaJson = [NSData data];
    if (aaa) {
        aaaJson = [NSJSONSerialization dataWithJSONObject:aaa options:NSJSONWritingPrettyPrinted error:nil];
    }
    NSString* aaastr = [[NSString alloc] initWithData:aaaJson encoding:NSUTF8StringEncoding];
    
    NSString *dataString  = nil;
    if ([ShareInstance shareInstance].staffId)//对data 加密
    {
        dataString = [self zipAndEncodeWithParam:param];
    }
    else
    {
        NSData* jsonData = [NSData data];
            jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        
         dataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];
    [allParam setObject:dataString forKey:@"data"];

    if (aaastr) {
        [allParam setObject:aaastr forKey:@"aaa"];
    }
    
//    [[AFAppDotNetAPIClient sharedClient] POST:HDLoginPath parameters:allParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    
    [[AFAppDotNetAPIClient sharedClient] POST:HDLoginPath parameters:allParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功");
        NSError *error = nil;
        id data = [responseObject objectForKey:@"data"];

        NSString *reusltStr = [self unzipResponsData:data];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@(2) forKey:@"sorttype"];
        [params setObject:@(1) forKey:@"searchtype"];
        [params setObject:@"" forKey:@"searchstr"];
        [params setObject:[ShareInstance shareInstance].staffId forKey:@"staffid"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    

}

// 加密
- (NSString *)zipAndEncodeWithParam:(NSDictionary *)param
{
    if (param == nil) {
        return nil;
    }
    NSData *paramData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    
    NSData *decData = [paramData gzipDeflate];//压缩
    decData = [HDBase64 encodeData:decData];//base64编码
    
    decData = [decData DESEncryptWithKey:@"12345678"];
    decData = [HDBase64 encodeData:decData];
    NSString *dataString = [[NSString alloc] initWithData:decData encoding:NSUTF8StringEncoding];
    
    return dataString;

}
- (NSString *)unzipResponsData:(NSString *)data
    {
        
        if (data == nil) {
            return nil;
        }
        
        NSData *responseData = [data dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *decData = [HDBase64 decodeData:responseData];//base64编码
        NSData *newData = [[NSData alloc] initWithData:decData];
        decData = [newData DESDecryptWithKey:@"12345678"];//解密
        
        decData = [HDBase64 decodeData:decData];//base64编码
        
        decData = [decData gzipInflate];//解压
        
        NSString *dataString = [[NSString alloc] initWithData:decData encoding:NSUTF8StringEncoding];
        
        return dataString;
}
@end
