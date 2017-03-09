//
//  HDCameraMaskView.m
//  AVCaptureDemo
//
//  Created by Handlecar on 2017/3/8.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "HDCameraMaskView.h"
#define CenterViewTag 100
#define ResultLabelTag 101
#define ResultImageTag 102
#define PromptLabeTag 104

@interface HDCameraMaskView ()


@end


@implementation HDCameraMaskView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.centerView = [self viewWithTag:CenterViewTag];
    self.resultLabel = (UILabel *)[self viewWithTag:ResultLabelTag];
    self.resultImageView = (UIImageView *)[self viewWithTag:ResultImageTag];
    self.promptLabel = (UILabel *)[self viewWithTag:PromptLabeTag];

    NSLog(@"centerView frame: %@",NSStringFromCGRect(self.centerView.frame));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    // Drawing code
    NSLog(@"draw rect");
    
    // 画边框
    CGRect centerRect = self.centerView.frame;
    
    
    [[UIColor greenColor] set];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线宽
    CGContextSetLineWidth(context, 2.0f);
    //画角线
    
    // 左上角
    CGContextMoveToPoint(context,centerRect.origin.x + 20, centerRect.origin.y);
    CGContextAddLineToPoint(context, centerRect.origin.x,centerRect.origin.y);
    CGContextAddLineToPoint(context, centerRect.origin.x,centerRect.origin.y + 20);

    // 右上角
    CGContextMoveToPoint(context, CGRectGetMaxX(centerRect) - 20, centerRect.origin.y);
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(centerRect),centerRect.origin.y);
    CGContextAddLineToPoint(context, CGRectGetMaxX(centerRect), centerRect.origin.y + 20);
//    CGContextMoveToPoint(context,leftBottom.x, leftBottom.y+20);
//    CGContextAddLineToPoint(context, leftBottom.x, leftBottom.y);
//    CGContextAddLineToPoint(context, leftBottom.x+20, leftBottom.y);
    
    // 左下角
    CGContextMoveToPoint(context,centerRect.origin.x + 20, CGRectGetMaxY(centerRect));
    CGContextAddLineToPoint(context, centerRect.origin.x,CGRectGetMaxY(centerRect));
    CGContextAddLineToPoint(context, centerRect.origin.x,CGRectGetMaxY(centerRect) - 20);
    
    // 右下角
    CGContextMoveToPoint(context, CGRectGetMaxX(centerRect) - 20, CGRectGetMaxY(centerRect));
    
    CGContextAddLineToPoint(context, CGRectGetMaxX(centerRect), CGRectGetMaxY(centerRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(centerRect), CGRectGetMaxY(centerRect) - 20);
    
    
    CGContextStrokePath(context);
    
    [[UIColor whiteColor] set];
    context = UIGraphicsGetCurrentContext();
    //设置线宽
    CGContextSetLineWidth(context, 0.2f);
    //画边线
    
    CGContextMoveToPoint(context, centerRect.origin.x, centerRect.origin.y);
    CGContextAddLineToPoint(context, CGRectGetMaxX(centerRect), centerRect.origin.y);
    CGContextAddLineToPoint(context, CGRectGetMaxX(centerRect), CGRectGetMaxY(centerRect));
    CGContextAddLineToPoint(context, centerRect.origin.x, CGRectGetMaxY(centerRect));
    CGContextAddLineToPoint(context, centerRect.origin.x, centerRect.origin.y);

    self.maskFrame.left = centerRect.origin.x;
    self.maskFrame.right = CGRectGetMaxX(centerRect);
    self.maskFrame.top = centerRect.origin.y;
    self.maskFrame.bottom = CGRectGetMaxY(centerRect);
    self.maskFrame.frame = centerRect;
    self.maskFrame.bounds = self.centerView.bounds;
    
    CGContextStrokePath(context);
}


- (HDSquare *)maskFrame
{
    if (!_maskFrame)
    {
        _maskFrame = [[HDSquare alloc] init];
        
        CGRect centerRect = self.centerView.frame;

        _maskFrame.left = centerRect.origin.x;
        _maskFrame.right = CGRectGetMaxX(centerRect);
        _maskFrame.top = centerRect.origin.y;
        _maskFrame.bottom = CGRectGetMaxY(centerRect);
        _maskFrame.frame = centerRect;
        _maskFrame.bounds = self.centerView.bounds;
    }
    return _maskFrame;
}

@end
