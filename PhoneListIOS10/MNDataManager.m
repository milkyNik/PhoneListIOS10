//
//  MNDataManager.m
//  PhoneListIOS10
//
//  Created by iMac on 03.03.17.
//  Copyright © 2017 hata. All rights reserved.
//

#import "MNDataManager.h"


@implementation MNDataManager

@synthesize persistentContainer = _persistentContainer;

+(MNDataManager*) sharedManager {
    
    static MNDataManager* manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[MNDataManager alloc] init];
    });
    
    return manager;
    
}

#pragma mark - Core Data stack

- (NSPersistentContainer*) persistentContainer {
    
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"PhoneListIOS10"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void) saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark - Delete all objects

- (void) deleteAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        
        [self.persistentContainer.viewContext deleteObject:object];
    }
    
    [self.persistentContainer.viewContext save:nil];
}

- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"MNUser"
                inManagedObjectContext:self.persistentContainer.viewContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

@end
