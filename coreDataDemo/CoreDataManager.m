//
//  CoreDataManager.m
//  coreDataDemo
//
//  Created by Handlecar on 16/5/17.
//  Copyright © 2016年 Handlecar. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (CoreDataManager *)sharedInstance
{
    static CoreDataManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CoreDataManager alloc] init];
    });
    return _sharedInstance;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }    NSError *error = nil;

    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:[self coreDataName] withExtension:@"momd"];
    if ([modelURL checkResourceIsReachableAndReturnError:&error] == NO){
        NSLog(@"Error: %@", error);     //[[NSAlert alertWithError:err] runModal];
    }
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (NSString *)coreDataName
{
    return @"coreDataDemo";
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator)
    {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *path = [self applicationDocumentsDirectory];
    NSURL *storeURL = [path URLByAppendingPathComponent:@"DownloadListDemo1.sqlite"];
    
    NSError *error = nil;
//    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
//                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
//                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSMutableDictionary *dict = [NSMutableDictionary  dictionary];
        dict[NSLocalizedDescriptionKey] = @"Fail to initialize the application's save data.";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error,[error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        
        NSError *error = nil;
        
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            // Replace this implementation with code to handle the error appropriately.
            
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            abort();
        }
    }
}

@end
