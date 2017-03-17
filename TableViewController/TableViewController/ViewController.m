//
//  ViewController.m
//  TableViewController
//
//  Created by Ais on 2017/3/12.
//  Copyright © 2017年 Ais. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *deleteButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *addButton;


@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.dataArray = [NSMutableArray new];
    
    NSString *itemFormatString = NSLocalizedString(@"Item %d", @"Format string for item");
    
    for (unsigned int itemNumber = 1; itemNumber < 12; itemNumber++) {
        NSString *itemName = [NSString stringWithFormat:itemFormatString,itemNumber];
        [self.dataArray addObject:itemName];
    }
    
}

#pragma mark - Updating button state

- (void)updateButtonsToMatchTableState
{
    if (self.tableView.editing)
    {
        self.navigationItem.rightBarButtonItem = self.cancelButton;
        
        
        
        self.navigationItem.leftBarButtonItem = self.deleteButton;
    }
    else
    {
        
    }
}
- (IBAction)editAction:(id)sender {
    [self.tableView setEditing:YES animated:YES];
    [self updateButtonsToMatchTableState];
}

- (IBAction)cancelAction:(id)sender {
    [self.tableView setEditing:NO animated:YES];
}
- (IBAction)deleteAction:(id)sender {
    NSString *actionTitle;
    if ([[self.tableView indexPathsForSelectedRows] count] == 1) {
        actionTitle = NSLocalizedString(@"Are you sure you want to remove this item?", @"");
    }
    else
    {
        actionTitle = NSLocalizedString(@"Are you sure you want to remove these items?", @"");
    }
    
    NSString *cancelTitle = NSLocalizedString(@"Cancel", @"Cancel title for item removal action");
    NSString *oKtitle = NSLocalizedString(@"OK", @"OK title for item removal action");
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle delegate:self cancelButtonTitle:cancelTitle destructiveButtonTitle:oKtitle otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}
- (IBAction)addAction:(id)sender {
    [self.tableView beginUpdates];
    
    [self.dataArray addObject:@"New Item"];
    
    NSIndexPath *indexPathOfNewItem = [NSIndexPath indexPathForRow:(self.dataArray.count - 1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPathOfNewItem] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
    [self updateButtonsToMatchTableState];
}

- (void)updateDeleteButtonTitle
{
    NSArray *selectRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectRows.count == self.dataArray.count;
    BOOL noItemsAreSelected = selectRows.count == 0;
    
    if (allItemsAreSelected || noItemsAreSelected) {
        self.deleteButton.title =  NSLocalizedString(@"Delete all", @"");
    }
    else
    {
        NSString *titleFormaString = NSLocalizedString(@"Delete (%d)", @"Title for delete button with placeholder for number");
        self.deleteButton.title = [NSString stringWithFormat:titleFormatString, selectRows.count];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
