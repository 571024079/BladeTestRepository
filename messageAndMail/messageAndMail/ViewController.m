//
//  ViewController.m
//  messageAndMail
//
//  Created by Handlecar on 16/5/10.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
@interface ViewController ()<MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *receiverTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageBodyTextField;
@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *attachments;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)sendMessageAction:(id)sender {
    //如果不能发送文本信息，就直接返回
    if (![MFMessageComposeViewController canSendText])
    {
        return;
    }
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    messageVC.recipients = [self.receiverTextField.text componentsSeparatedByString:@","];
    // 设置信息正文
    messageVC.body = self.messageBodyTextField.text;
    messageVC.messageComposeDelegate = self;
    //判断是否支持主题
    if ([MFMessageComposeViewController canSendSubject])
    {
        messageVC.subject = self.subjectTextField.text;
    }
    
    if ([MFMessageComposeViewController canSendAttachments])
    {
        NSArray *attachments = [self.attachments.text componentsSeparatedByString:@","];
        if (attachments.count > 0)
        {
            
        }
    }
    [self presentViewController:messageVC animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功.");
            break;
        case MessageComposeResultCancelled:
            NSLog(@"取消发送.");
            break;
        default:
            NSLog(@"发送失败.");
            break;
    }
    //弹回界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
