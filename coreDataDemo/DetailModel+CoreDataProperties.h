//
//  DetailModel+CoreDataProperties.h
//  coreDataDemo
//
//  Created by Handlecar on 16/5/18.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *badImage;
@property (nullable, nonatomic, retain) NSNumber *ccirrciid;
@property (nullable, nonatomic, retain) id checkresultid;
@property (nullable, nonatomic, retain) NSNumber *goodphotoid;
@property (nullable, nonatomic, retain) NSNumber *pbflg;
@property (nullable, nonatomic, retain) NSString *photoid;
@property (nullable, nonatomic, retain) NSString *photoid1;
@property (nullable, nonatomic, retain) NSString *photomasterurl;
@property (nullable, nonatomic, retain) NSNumber *photoprourl;
@property (nullable, nonatomic, retain) NSString *photoremark;
@property (nullable, nonatomic, retain) NSString *photourl;
@property (nullable, nonatomic, retain) CpositemsModel *relationship;
//@property (nullable, nonatomic, retain) NSSet<ListCoredataModel *> *clist;

@end

@interface DetailModel (CoreDataGeneratedAccessors)

- (void)addClistObject:(ListCoredataModel *)value;
- (void)removeClistObject:(ListCoredataModel *)value;
- (void)addClist:(NSSet<ListCoredataModel *> *)values;
- (void)removeClist:(NSSet<ListCoredataModel *> *)values;

@end

NS_ASSUME_NONNULL_END
