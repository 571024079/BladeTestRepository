//
//  MutipleTextFieldAccessView.m
//  MutipleAccessView
//
//  Created by Handlecar on 2017/2/17.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "MutipleTextFieldAccessView.h"

#define FONTSIZE  14
#define SPACE     5

@implementation MutipleTextFieldAccessView

+ (MutipleTextFieldAccessView *)accessViewWithTextFieldCount:(NSNumber *)count textLengthLimit:(NSNumber *)limitlength title:(NSString *)title hostTextField:(UITextField *)textField
{
    MutipleTextFieldAccessView *view = [[MutipleTextFieldAccessView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 40)];
    view.title = title;
    view.textFieldcount = count;
    view.textLimitCount = limitlength;
    view.backgroundColor = [UIColor redColor];
    [view configView];
    return view;
}

- (void)configView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, self.bounds.size.height)];
    titleLabel.text = self.title;
    [self addSubview:titleLabel];
    
    CGFloat textFieldWidth = 60;
    
    for (NSInteger i = 0; i <  [self.textFieldcount integerValue]; i++)
    {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.bounds.size.width + i * (textFieldWidth + SPACE), SPACE, textFieldWidth, CGRectGetHeight(self.bounds) - SPACE * 2)];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont systemFontOfSize:FONTSIZE];
        [self addSubview:textField];
    }
}



@end
