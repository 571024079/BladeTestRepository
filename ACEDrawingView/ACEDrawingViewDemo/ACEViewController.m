//
//  ACEViewController.m
//  ACEDrawingViewDemo
//
//  Created by Stefano Acerbetti on 1/6/13.
//  Copyright (c) 2013 Stefano Acerbetti. All rights reserved.
//

#import "ACEViewController.h"
#import "ACEDrawingView.h"

#import <QuartzCore/QuartzCore.h>

#define kActionSheetColor       100
#define kActionSheetTool        101

@interface ACEViewController ()<UIActionSheetDelegate, ACEDrawingViewDelegate>
@property (nonatomic, unsafe_unretained) IBOutlet ACEDrawingView *drawingView;
@property (nonatomic, unsafe_unretained) IBOutlet UIBarButtonItem *undoButton;
@property (weak, nonatomic) IBOutlet UIView *markView;

@property (nonatomic, strong) NSMutableArray *markArr;
@end

@implementation ACEViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the delegate
    self.drawingView.delegate = self;
    self.drawingView.backgroundColor = [UIColor clearColor];
    self.drawingView.lineWidth = 2;
    
    // init the mark view
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addOneMark:)];
    self.markArr = [NSMutableArray new];
    [self.markView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (void)updateButtonStatus
{
    self.undoButton.enabled = [self.drawingView canUndo];
}

- (void)addOneMark:(UITapGestureRecognizer *)gesture{
    CGPoint tapPoint = [gesture locationInView:self.markView];
    UIButton *button = [UIButton new];
    button.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    button.titleLabel.font = [UIFont systemFontOfSize:25];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.center = CGPointMake(tapPoint.x, tapPoint.y-20);
    [button addTarget:self action:@selector(removeOneMark:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:[NSString stringWithFormat:@"%d",(int)self.markArr.count+1] forState:UIControlStateNormal];
    [self.drawingView addSubview:button];
    [self.markArr addObject:button];
}

- (IBAction)addMark:(id)sender {
    self.markView.hidden = !self.markView.isHidden;
}

- (void)removeOneMark:(UIButton *)sender{
    [sender removeFromSuperview];
    [self.markArr removeObject:sender];
    [self reflashMarkNum];
}

- (void)reflashMarkNum{
    for (int i = 0; i< self.markArr.count; i++) {
        UIButton *button = self.markArr[i];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
    }
}

- (IBAction)takeScreenshot:(id)sender
{
    // show the preview image
    //单纯路线image
//    UIImage *image = self.drawingView.image;
    //包括底图image
    UIImage *image = [self snapshot:self.view];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"temp.jpg"]];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
    NSLog(@"%d:\n%@",result,filePath);
    
    // close it after 3 seconds
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
//        self.previewImageView.hidden = YES;
//    });
}

#pragma mark - Private method
- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (IBAction)undo:(id)sender
{
    [self.drawingView undoLatestStep];
    [self updateButtonStatus];
}

- (IBAction)clear:(id)sender
{
    [self.drawingView clear];
    [self updateButtonStatus];
}


#pragma mark - ACEDrawing View Delegate

- (void)drawingView:(ACEDrawingView *)view didEndDrawUsingTool:(id<ACEDrawingTool>)tool;
{
    [self updateButtonStatus];
}


@end
