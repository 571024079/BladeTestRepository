//
//  CpositemsModel+CoreDataProperties.h
//  coreDataDemo
//
//  Created by Handlecar on 16/5/18.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CpositemsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CpositemsModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *badPhotoCount;
@property (nullable, nonatomic, retain) NSNumber *cgoodphotoid;
@property (nullable, nonatomic, retain) NSString *cgoodphotoprourl;
@property (nullable, nonatomic, retain) NSString *cgoodphotourl;
@property (nullable, nonatomic, retain) NSNumber *cguideid;
@property (nullable, nonatomic, retain) NSString *cguideimg;
@property (nullable, nonatomic, retain) NSString *cguideremark;
@property (nullable, nonatomic, retain) NSNumber *cid;
@property (nullable, nonatomic, retain) NSString *cname;
@property (nullable, nonatomic, retain) NSNumber *cnt;
@property (nullable, nonatomic, retain) NSNumber *cpartid;
@property (nullable, nonatomic, retain) NSNumber *cpbcnt;
@property (nullable, nonatomic, retain) Ncb015CoredataModel *relationship;
@property (nullable, nonatomic, retain) NSSet<DetailModel *> *cbadphotos;
@property (nullable, nonatomic, retain) NSSet<ListCoredataModel *> *clist;

@end

@interface CpositemsModel (CoreDataGeneratedAccessors)

- (void)addCbadphotosObject:(DetailModel *)value;
- (void)removeCbadphotosObject:(DetailModel *)value;
- (void)addCbadphotos:(NSSet<DetailModel *> *)values;
- (void)removeCbadphotos:(NSSet<DetailModel *> *)values;

- (void)addClistObject:(ListCoredataModel *)value;
- (void)removeClistObject:(ListCoredataModel *)value;
- (void)addClist:(NSSet<ListCoredataModel *> *)values;
- (void)removeClist:(NSSet<ListCoredataModel *> *)values;

@end

NS_ASSUME_NONNULL_END
