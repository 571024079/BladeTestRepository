//
//  ViewController.m
//  TableView
//
//  Created by Handlecar on 4/28/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "ViewController.h"
#import "FirstCell.h"
#import "TwoCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableSet *cellSet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _cellSet = [NSMutableSet set];
    CALayer *layer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusestr = @"reusestr";
    FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:reusestr];
    cell.nameLabel.text = [NSString stringWithFormat:@"名字：%ld",indexPath.row];
    [_cellSet addObject:cell];
    NSString *str = @"未选中";
    if (cell.selected)
    {
        str = @"选中";
    }
    
    NSLog(@"第%ld行，%@",indexPath.row,str);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.selected)
    {
        NSLog(@"选中,第%ld行",indexPath.row);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"反选");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
