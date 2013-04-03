//
//  MovobiAppDelegate.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiAppDelegate.h"
#import "MovobiMasterViewController.h"
#import "MovobiImageTransformer.h"
#import "Movie.h"
#import "Tag.h"
#import "Screen.h"

@implementation MovobiAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*NSManagedObjectContext *context = [self managedObjectContext];
    Movie *movie = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Movie"
                        inManagedObjectContext:context];
    movie.name = @"Casino Royale";
    movie.resolutionWidth = [NSNumber numberWithInt:1080];
    movie.resolutionHeight = [NSNumber numberWithInt:700];
    Screen *screen = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Screen"
                            inManagedObjectContext:context];    

    NSString *imageName = [[NSBundle mainBundle] pathForResource:@"Ninja_01a" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imageName];
    
    screen.image = image;
    screen.time = [NSNumber numberWithInt:4];
    screen.movie = movie;
    
    NSMutableSet *screens = [[NSMutableSet alloc] initWithCapacity:(1)];
    [screens addObject:screen];
    movie.screens = screens;
    
    Tag *tag = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Tag"
                        inManagedObjectContext:context];
    tag.desc = @"James Bond's Watch";
    tag.rectTopLeftX = [NSNumber numberWithFloat:0.5];
    tag.rectTopLeftY = [NSNumber numberWithFloat:0.7];
    tag.rectWidth = [NSNumber numberWithFloat:0.1];
    tag.rectHeight = [NSNumber numberWithFloat:0.15];
    tag.timeStart = [NSNumber numberWithInt:5];
    tag.timeEnd = [NSNumber numberWithInt:6];
    tag.movie = movie;
    
    NSMutableSet *tags = [[NSMutableSet alloc] initWithCapacity:(1)];
    [tags addObject:tag];
    movie.tags = tags;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                    entityForName:@"Movie" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Movie *move in fetchedObjects) {
        NSLog(@"Name: %@", movie.name);
        NSArray *screens = [movie.screens allObjects];
        for (Screen *screen in screens)
        {
            NSLog(@"Time: %@", screen.time);
        }
        NSArray *tags = [movie.tags allObjects];
        for (Tag *tag in tags)
        {
            NSLog(@"Time: %@", tag.desc);
        }
    }
    */
  /*
    NSManagedObjectContext *context = [self managedObjectContext];
     Movie *movie = [NSEntityDescription
     insertNewObjectForEntityForName:@"Movie"
     inManagedObjectContext:context];
     movie.name = @"Snow White";
     movie.resolutionWidth = [NSNumber numberWithInt:500];
     movie.resolutionHeight = [NSNumber numberWithInt:300];
   
    NSMutableSet *screens = [[NSMutableSet alloc] initWithCapacity:(2)];
    
    Screen *screen0 = [NSEntityDescription
     insertNewObjectForEntityForName:@"Screen"
     inManagedObjectContext:context];
    NSString *imageName = [[NSBundle mainBundle] pathForResource:@"sw1" ofType:@"jpg"];
     UIImage *image = [UIImage imageWithContentsOfFile:imageName];
     screen0.image = image;
     screen0.time = [NSNumber numberWithInt:8];
     screen0.movie = movie;
     [screens addObject:screen0];
    
    Screen *screen1 = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Screen"
                       inManagedObjectContext:context];
    NSString *imageName1 = [[NSBundle mainBundle] pathForResource:@"sw2" ofType:@"jpg"];
    UIImage *image1 = [UIImage imageWithContentsOfFile:imageName1];
    screen1.image = image1;
    screen1.time = [NSNumber numberWithInt:60];
    screen1.movie = movie;
    [screens addObject:screen1];
    
    movie.screens = screens;
     
     NSMutableSet *tags = [[NSMutableSet alloc] initWithCapacity:(3)];
    
     Tag *tag0 = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Tag"
                 inManagedObjectContext:context];
     tag0.desc = @"Wicked Witch";
     tag0.rectTopLeftX = [NSNumber numberWithFloat:0.5];
     tag0.rectTopLeftY = [NSNumber numberWithFloat:0.7];
     tag0.rectWidth = [NSNumber numberWithFloat:0.1];
     tag0.rectHeight = [NSNumber numberWithFloat:0.15];
     tag0.timeStart = [NSNumber numberWithInt:5];
     tag0.timeEnd = [NSNumber numberWithInt:6];
     tag0.movie = movie;
     [tags addObject:tag0];
    
    Tag *tag1 = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Tag"
                 inManagedObjectContext:context];
    tag1.desc = @"Posined Apple";
    tag1.rectTopLeftX = [NSNumber numberWithFloat:0.5];
    tag1.rectTopLeftY = [NSNumber numberWithFloat:0.7];
    tag1.rectWidth = [NSNumber numberWithFloat:0.1];
    tag1.rectHeight = [NSNumber numberWithFloat:0.15];
    tag1.timeStart = [NSNumber numberWithInt:10];
    tag1.timeEnd = [NSNumber numberWithInt:11];
    tag1.movie = movie;
    [tags addObject:tag1];
    

    Tag *tag2 = [NSEntityDescription
                 insertNewObjectForEntityForName:@"Tag"
                 inManagedObjectContext:context];
    tag2.desc = @"Dwarves";
    tag2.rectTopLeftX = [NSNumber numberWithFloat:0.5];
    tag2.rectTopLeftY = [NSNumber numberWithFloat:0.7];
    tag2.rectWidth = [NSNumber numberWithFloat:0.1];
    tag2.rectHeight = [NSNumber numberWithFloat:0.15];
    tag2.timeStart = [NSNumber numberWithInt:20];
    tag2.timeEnd = [NSNumber numberWithInt:80];
    tag2.movie = movie;
    [tags addObject:tag2];

    
    movie.tags = tags;
     
     NSError *error;
     if (![context save:&error]) {
     NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
     }
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription
     entityForName:@"Movie" inManagedObjectContext:context];
     [fetchRequest setEntity:entity];
     NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
     for (Movie *move in fetchedObjects) {
     NSLog(@"Name: %@", movie.name);
     NSArray *screens = [movie.screens allObjects];
     for (Screen *screen in screens)
     {
     NSLog(@"Time: %@", screen.time);
     }
     NSArray *tags = [movie.tags allObjects];
     for (Tag *tag in tags)
     {
     NSLog(@"Time: %@", tag.desc);
     }
     }*/
     
    
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MovobiMasterViewController *controller = (MovobiMasterViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"movobi" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"movobi.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
