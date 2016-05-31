//
//  Ncb015CoredataModel+CoreDataProperties.h
//  coreDataDemo
//
//  Created by Handlecar on 16/5/18.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Ncb015CoredataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ncb015CoredataModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cposid;
@property (nullable, nonatomic, retain) NSString *cposname;
@property (nullable, nonatomic, retain) FastCheckModel *relationship;
@property (nullable, nonatomic, retain) NSSet<CpositemsModel *> *cpositems;

@end

@interface Ncb015CoredataModel (CoreDataGeneratedAccessors)

- (void)addCpositemsObject:(CpositemsModel *)value;
- (void)removeCpositemsObject:(CpositemsModel *)value;
- (void)addCpositems:(NSSet<CpositemsModel *> *)values;
- (void)removeCpositems:(NSSet<CpositemsModel *> *)values;

@end

NS_ASSUME_NONNULL_END
