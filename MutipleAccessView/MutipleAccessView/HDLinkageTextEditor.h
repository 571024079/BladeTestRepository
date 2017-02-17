//
//  HDLinkageTextEditor.h
//  MutipleAccessView
//
//  Created by Handlecar on 2017/2/17.
//  Copyright © 2017年 handlecar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDLinkageTextEditor : UIView

@property (nonatomic) NSInteger textParts; // 文本框个数
@property (nonatomic) NSInteger textLengthLimit; // 文本长度限制

@property (nonatomic) UITextBorderStyle borderStyle; // 文本框样式


+ (HDLinkageTextEditor *)linkageTextEditorWithTextParts:(NSInteger)parts borderStyle:(UITextBorderStyle)style textLengthLimit:(NSInteger)limitLength frame:(CGRect)frame;

@end
