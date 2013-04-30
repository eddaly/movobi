//
//  MovobiMasterViewController.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiMasterViewController.h"
#import "MovobiFilmViewController.h"
#import "MovobiFilmScreensViewController.h"
#import "MovobiMObjectsViewController.h"
#import "Film.h"
#import "Screen.h"
#import "MOActor.h"
#import "MOCharacter.h"
#import "MOProp.h"
#import "MOLocation.h"

@implementation MovobiMasterViewController

@synthesize managedObjectContext;
@synthesize films;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    [fetchRequest setSortDescriptors: sortDescriptors];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Film" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.films = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [films count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Film";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    Film *film = [films objectAtIndex:indexPath.row];
    cell.textLabel.text = film.name;
    cell.detailTextLabel.text = film.year;
    cell.imageView.image = film.image;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowFilm" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFilm"])
    {
        UITabBarController *tabBarController = [segue destinationViewController];
        
        // Set film for the film detail view
        MovobiFilmViewController *filmViewController = [[tabBarController viewControllers] objectAtIndex: 0];
        filmViewController.film = [films objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        // Sort and set screens array for the screens view
        MovobiFilmScreensViewController *filmScreensViewController = [[tabBarController viewControllers] objectAtIndex: 1];
        NSSortDescriptor *descriptorTimeStart = [[NSSortDescriptor alloc] initWithKey:@"timeStart" ascending:YES];
        filmScreensViewController.screens = [filmViewController.film.screens sortedArrayUsingDescriptors: [NSArray arrayWithObject:descriptorTimeStart]];
    
        // Sort and set MObjects arrays for the screens view
        NSSortDescriptor *descriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
        MovobiMObjectsViewController *moactorsViewController = [[tabBarController viewControllers] objectAtIndex: 2];
        MovobiMObjectsViewController *mocharactersViewController = [[tabBarController viewControllers] objectAtIndex: 3];
        MovobiMObjectsViewController *mopropsViewController = [[tabBarController viewControllers] objectAtIndex: 4];
        MovobiMObjectsViewController *molocsViewController = [[tabBarController viewControllers] objectAtIndex: 5];
        
        NSArray *mobjectsArray = [filmViewController.film.mobjects sortedArrayUsingDescriptors: [NSArray arrayWithObject:descriptorName]];
        NSMutableArray *moactorsArray = [NSMutableArray arrayWithCapacity: 0];
        NSMutableArray *mocharactersArray = [NSMutableArray arrayWithCapacity: 0];
        NSMutableArray *mopropsArray = [NSMutableArray arrayWithCapacity: 0];
        NSMutableArray *molocsArray = [NSMutableArray arrayWithCapacity: 0];
        for (MObject *mobject in mobjectsArray)
        {
            if ([mobject isMemberOfClass:[MOActor class]])
            {
                [moactorsArray addObject: mobject];
            }
            else if ([mobject isMemberOfClass:[MOCharacter class]])
            {
                [mocharactersArray addObject:mobject];
            }
            else if ([mobject isMemberOfClass:[MOProp class]])
            {
                [mopropsArray addObject:mobject];
            }
            else if ([mobject isMemberOfClass:[MOLocation class]])
            {
                [molocsArray addObject:mobject];
            }
        }
        moactorsViewController.mobjects = moactorsArray;
        moactorsViewController.useClassSpecificDetailViews = YES;
        mocharactersViewController.mobjects = mocharactersArray;
        mocharactersViewController.useClassSpecificDetailViews = YES;
        mopropsViewController.mobjects = mopropsArray;
        molocsViewController.mobjects = molocsArray;
    }
}

@end
