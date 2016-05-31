//
//  ViewController.m
//  TextViewMarkedRange
//
//  Created by Handlecar on 16/5/27.
//  Copyright © 2016年 date. All rights reserved.
//

#import "ViewController.h"

#define MAX_LIMIT_NUMS 10

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labLimitNum;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
 }


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    UITextRange *selectRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectRange.start offset:0];
    
    NSString *selectText = [textView textInRange:selectRange];
    if (selectRange && pos )
    {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectRange.end];
        
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < MAX_LIMIT_NUMS)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger inputlen = MAX_LIMIT_NUMS - comcatstr.length;
    if (inputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + inputlen;
        
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错﻿﻿
        
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
            
        {
            
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            
            //既然是超出部分截取了，哪一定是最大限制了。﻿﻿
            
            self.labLimitNum.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
            
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView

{
    
    UITextRange *selectedRange = [textView markedTextRange];
    
    //获取高亮部分﻿﻿
    
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了﻿﻿
    
    if (selectedRange && pos) {
        return;
    }
    
    NSString *nsTextContent = textView.text;
    
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
        
    {
        
        //截取到最大位置的字符﻿﻿
        
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
        
    }
    
    //不让显示负数﻿﻿
    
    self.labLimitNum.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
