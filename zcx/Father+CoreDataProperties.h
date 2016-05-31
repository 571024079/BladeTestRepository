//
//  Father+CoreDataProperties.h
//  zcx
//
//  Created by Handlecar on 16/5/17.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Father.h"

NS_ASSUME_NONNULL_BEGIN

@interface Father (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *children;
@property (nullable, nonatomic, retain) Grandepa *father_grandepa;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *father_child;

@end

@interface Father (CoreDataGeneratedAccessors)

- (void)addFather_childObject:(NSManagedObject *)value;
- (void)removeFather_childObject:(NSManagedObject *)value;
- (void)addFather_child:(NSSet<NSManagedObject *> *)values;
- (void)removeFather_child:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
