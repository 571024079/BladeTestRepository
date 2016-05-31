//
//  Grandepa+CoreDataProperties.h
//  zcx
//
//  Created by Handlecar on 16/5/17.
//  Copyright © 2016年 Handlecar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Grandepa.h"

NS_ASSUME_NONNULL_BEGIN

@interface Grandepa (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) id sons;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *grandepa_father;

@end

@interface Grandepa (CoreDataGeneratedAccessors)

- (void)addGrandepa_fatherObject:(NSManagedObject *)value;
- (void)removeGrandepa_fatherObject:(NSManagedObject *)value;
- (void)addGrandepa_father:(NSSet<NSManagedObject *> *)values;
- (void)removeGrandepa_father:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
