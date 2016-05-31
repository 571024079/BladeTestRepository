//
//  FastCheckModel+CoreDataProperties.h
//  coreDataDemo
//
//  Created by Handlecar on 16/5/18.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FastCheckModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FastCheckModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cstatus;
@property (nullable, nonatomic, retain) NSNumber *cstatusid;
@property (nullable, nonatomic, retain) NSString *remark;
@property (nullable, nonatomic, retain) NSSet<Ncb015CoredataModel *> *ncb015list;

@end

@interface FastCheckModel (CoreDataGeneratedAccessors)

- (void)addNcb015listObject:(Ncb015CoredataModel *)value;
- (void)removeNcb015listObject:(Ncb015CoredataModel *)value;
- (void)addNcb015list:(NSSet<Ncb015CoredataModel *> *)values;
- (void)removeNcb015list:(NSSet<Ncb015CoredataModel *> *)values;

@end

NS_ASSUME_NONNULL_END
