//
//  Film.h
//  movobi
//
//  Created by Ed Daly on 27/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MObject, Screen;

@interface Film : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * flags;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSSet *mobjects;
@property (nonatomic, retain) NSSet *screens;
@end

@interface Film (CoreDataGeneratedAccessors)

- (void)addMobjectsObject:(MObject *)value;
- (void)removeMobjectsObject:(MObject *)value;
- (void)addMobjects:(NSSet *)values;
- (void)removeMobjects:(NSSet *)values;

- (void)addScreensObject:(Screen *)value;
- (void)removeScreensObject:(Screen *)value;
- (void)addScreens:(NSSet *)values;
- (void)removeScreens:(NSSet *)values;

@end
