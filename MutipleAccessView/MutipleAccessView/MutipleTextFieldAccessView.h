//
//  MutipleTextFieldAccessView.h
//  MutipleAccessView
//
//  Created by Handlecar on 2017/2/17.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MutipleTextFieldAccessView : UIView

@property (nonatomic, strong) NSNumber *textFieldcount;  // 格子数量
@property (nonatomic, strong) NSNumber *textLimitCount; // 文本长度限制
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) UITextField *hostTextField; // 宿主 textField

+ (MutipleTextFieldAccessView *)accessViewWithTextFieldCount:(NSNumber *)count textLengthLimit:(NSNumber *)limitlength title:(NSString *)title hostTextField:(UITextField *)textField;

@end
