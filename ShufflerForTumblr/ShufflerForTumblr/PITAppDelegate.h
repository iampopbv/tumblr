//
//  PITAppDelegate.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 30/04/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PITAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
