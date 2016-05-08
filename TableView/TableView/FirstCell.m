//
//  FirstCell.m
//  TableView
//
//  Created by Handlecar on 4/28/16.
//  Copyright © 2016 Handlecar. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected)
    {
        self.nameLabel.textColor = [UIColor blueColor];
    }
    else
    {
        self.nameLabel.textColor = [UIColor blackColor];
    }
}

@end
