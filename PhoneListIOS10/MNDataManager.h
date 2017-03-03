//
//  MNDataManager.h
//  PhoneListIOS10
//
//  Created by iMac on 03.03.17.
//  Copyright © 2017 hata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MNDataManager : NSObject

@property (readonly, strong) NSPersistentContainer* persistentContainer;

+(MNDataManager*) sharedManager;

- (void) saveContext;

- (NSArray*) allObjects;
- (void) deleteAllObjects;

@end
