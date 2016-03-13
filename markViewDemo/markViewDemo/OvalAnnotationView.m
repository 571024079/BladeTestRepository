//
//  OvalAnnotationView.m
//  markViewDemo
//
//  Created by Handlecar on 3/13/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "OvalAnnotationView.h"


#define LineWidth 20

#define TouchButtonTag  200

#define TipWidth        40

#define TipHeight       40

@interface OvalAnnotationView()

@property (nonatomic, strong) CAShapeLayer *ovalLayer;
@property (nonatomic, strong) UILabel *tip;
@end

@implementation OvalAnnotationView


- (void)drawRect:(CGRect)rect
{
    
    
    if (!self.layer.sublayers.count)
    {
        UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        oval.lineCapStyle = kCGLineCapRound;
        oval.lineWidth = LineWidth;
        
        
        _ovalLayer = [CAShapeLayer layer];
        _ovalLayer.frame = self.bounds;
        _ovalLayer.fillColor = [UIColor clearColor].CGColor;
        _ovalLayer.strokeColor = [UIColor redColor].CGColor;
        _ovalLayer.path = oval.CGPath;
        _ovalLayer.backgroundColor = [UIColor clearColor].CGColor;

        [self.layer addSublayer:_ovalLayer];
    }
    else
    {
        UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        oval.lineCapStyle = kCGLineCapRound;
        oval.lineWidth = LineWidth;
        _ovalLayer.frame = self.bounds;
        _ovalLayer.path = oval.CGPath;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTipContent];
    }
    return self;
}

- (void)setTipContent
{

    _tip = [[UILabel alloc] init];
    [self addSubview:_tip];
    
}


- (void)updateButtonFrame
{
    _tip.frame = CGRectMake((self.bounds.size.width - TipWidth) / 2.0f, 10, TipWidth, TipHeight);
}

- (void)setTipColor:(UIColor *)tipColor
{
    _tipColor = tipColor;
    _tip.backgroundColor = tipColor;
}

- (void)setTipCorner:(CGFloat)tipCorner
{
    _tip.layer.cornerRadius = tipCorner;
    _tip.layer.masksToBounds = YES;
}

@end
