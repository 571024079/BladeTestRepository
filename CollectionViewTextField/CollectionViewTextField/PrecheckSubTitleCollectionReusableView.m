//
//  PrecheckSubTitleCollectionReusableView.m
//  HandleiPad
//
//  Created by Handlecar on 2017/3/2.
//  Copyright © 2017年 Handlecar1. All rights reserved.
//

#import "PrecheckSubTitleCollectionReusableView.h"
//#import "HDPreCheckModel.h"
//#import "PorscheMultipleListhView.h"

@interface PrecheckSubTitleCollectionReusableView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldArray;


@end

@implementation PrecheckSubTitleCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.cornerRadius = 3;
//    self.contentView.layer.borderColor = PRECHECK_BORDER_COLOR.CGColor;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 1.0f;
    
    //给所有的输入框设置代理
    for (UITextField *textFidle in _textFieldArray) {
        textFidle.delegate = self;
        textFidle.returnKeyType = UIReturnKeyDone;
        if (textFidle == _chejiahaoTF || textFidle == _carPlateTF || textFidle == _dateTF) {
            textFidle.userInteractionEnabled = NO;
            textFidle.borderStyle = UITextBorderStyleNone;
        }
    }
}

//- (void)setPreCheckData:(HDPreCheckModel *)preCheckData {
//    _preCheckData = preCheckData;
//    if (_preCheckData) {
//        _orderNumTF.text = _preCheckData.dmsno;
//        _checkStaffNameTF.text = _preCheckData.checkpersonname;
//        _chejiahaoTF.text = _preCheckData.vin;
//        _carPlateTF.text = _preCheckData.plateall;
//        _dateTF.text = [_preCheckData.checkday convertFromFormat:@"yyyyMMddHHmmss" toAnotherFormat:@"yyyy-MM-dd HH:mm:ss"];
//        _currentMileageTF.text = _preCheckData.curmiles ? [[NSString formatMoneyStringWithMilesFloat:_preCheckData.curmiles.floatValue] stringByAppendingString:@"公里"] : @"";
//    }
//}


#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    NSLog(@"textFieldShouldBeginEditing %@ \n",textField);
//    if (textField == _checkStaffNameTF) {
//        [self showChooseBottomNameWithTF:textField];
//        return NO;
//    }else {
//        return YES;
//    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    if (_textFieldBlock) {
//        _textFieldBlock((PrecheckSubTitleTF)textField.tag, textField, nil);
//    }
}


- (void)showChooseBottomNameWithTF:(UITextField *)tf {
//    WeakObject(tf)
//    WeakObject(self);
    // 获取组中员工数组
//    [PorscheRequestManager getStaffListTestWithGroupId:@1 positionId:@3 complete:^(NSMutableArray * _Nonnull classifyArray, PResponseModel * _Nonnull responser) {
//        
//        __block BOOL isMore = NO;
//        __block PorscheConstantModel *tmpModel;
//        if (classifyArray.count) {
//            for (PorscheConstantModel *tmp in classifyArray) {
//                if ([tmp.cvsubid integerValue] != 1) {
//                    isMore = YES;
//                }else {
//                    tmpModel = tmp;
//                }
//                
//            }
//        }
//        
//        PorscheConstantModel *more;
//        if (isMore) {
//            more = [PorscheConstantModel new];
//            more.cvsubid = @-1;
//            more.cvvaluedesc = @"其他";
//            [classifyArray insertObject:more atIndex:0];
//        }
//        
//        NSMutableArray *groupArray = [classifyArray mutableCopy];
//        if (tmpModel) {
//            [groupArray removeObject:tmpModel];
//        }
//        
//        
//        [PorscheMultipleListhView showSingleListViewFrom:tf dataSource:groupArray selected:nil showArrow:NO direction:ListViewDirectionUp complete:^(PorscheConstantModel *constantModel, NSInteger idx) {
//            if ([constantModel.cvsubid isEqual:@-1] && [constantModel.cvvaluedesc isEqualToString:@"其他"]) {
//                tfWeak.text = @"";
//            }else {
//                tfWeak.text = constantModel.cvvaluedesc;
//            }
//            if (selfWeak.textFieldBlock) {
//                selfWeak.textFieldBlock((PrecheckSubTitleTF)tfWeak.tag, tfWeak, constantModel);
//            }
//        }];
//    }];
    
}


@end
