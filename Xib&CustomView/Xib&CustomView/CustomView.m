//
//  CustomView.m
//  Xib&CustomView
//
//  Created by Handlecar on 2017/3/6.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"调用了 %s",__func__);

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    NSLog(@"调用了 %s",__func__);
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"调用了 %s",__func__);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
