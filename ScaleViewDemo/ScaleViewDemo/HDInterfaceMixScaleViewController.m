//
//  HDInterfaceMixScaleViewController.m
//  ScaleViewDemo
//
//  Created by Handlecar on 16/7/11.
//  Copyright © 2016年 handlecar. All rights reserved.
//

#import "HDInterfaceMixScaleViewController.h"

@interface HDInterfaceMixScaleViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation HDInterfaceMixScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 3.0f;
}
- (IBAction)tapGesture:(id)sender {
    NSLog(@"tap");
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {
        return self.contentView;
    }
    else
    {
        return nil;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //    self.contentView.transform = CGAffineTransformMakeScale(scrollView.zoomScale, scrollView.zoomScale);
    NSLog(@"11111");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseStr = @"reusestr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseStr];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseStr];
        cell.backgroundColor = [UIColor blueColor];
    }
    cell.textLabel.text = @"go to hell";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
