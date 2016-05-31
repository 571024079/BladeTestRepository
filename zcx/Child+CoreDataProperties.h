//
//  Child+CoreDataProperties.h
//  zcx
//
//  Created by Handlecar on 16/5/17.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Child.h"

NS_ASSUME_NONNULL_BEGIN

@interface Child (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) id toys;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) Father *child_father;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *child_toys;

@end

@interface Child (CoreDataGeneratedAccessors)

- (void)addChild_toysObject:(NSManagedObject *)value;
- (void)removeChild_toysObject:(NSManagedObject *)value;
- (void)addChild_toys:(NSSet<NSManagedObject *> *)values;
- (void)removeChild_toys:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
