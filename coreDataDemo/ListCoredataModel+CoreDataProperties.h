//
//  ListCoredataModel+CoreDataProperties.h
//  coreDataDemo
//
//  Created by Handlecar on 16/5/18.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ListCoredataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListCoredataModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cid;
@property (nullable, nonatomic, retain) NSString *cname;
@property (nullable, nonatomic, retain) NSNumber *color;
@property (nullable, nonatomic, retain) CpositemsModel *relationship;

@end

NS_ASSUME_NONNULL_END
