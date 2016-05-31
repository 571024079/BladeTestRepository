//
//  Toys+CoreDataProperties.h
//  zcx
//
//  Created by Handlecar on 16/5/17.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Toys.h"

NS_ASSUME_NONNULL_BEGIN

@interface Toys (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cost;
@property (nullable, nonatomic, retain) Child *toys_child;

@end

NS_ASSUME_NONNULL_END
